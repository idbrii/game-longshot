local Barracks = require('barracks')
local Bomb = require('bomb')
local Launcher = require('launcher')
local M = require("moses.moses")
local Resourcer = require('resourcer')
local Tech = require('tech')
local Vec = require('hump.vector')
local baton = require "baton.baton"
local class = require('astray.MiddleClass')
local colorizer = require('colorizer')
local lume = require('rxi.lume')
local moremath = require('moremath')
local moretable = require('moretable')
local pl_table = require('pl.tablex')
local screener = require "screener"
local wf = require('windfield')


local Player = class('Player')

local k_mouse_player_id = 1
local k_gamepad_player_id = 2

local k_launch_offset = 50
local k_launch_minimum_intensity = 0.1
local k_launch_minimum_held_seconds = 0.3
local k_launch_maximum_held_seconds = 2
local k_launch_default_power = 500

local k_projectile_id_to_name = {
    'launcher',
    'barracks',
    'resourcer',
    'bomb',
}
local k_projectile_id = pl_table.index_map(k_projectile_id_to_name)
local k_projectile_id_to_class = {
    Launcher,
    Barracks,
    Resourcer,
    Bomb,
}




function Player:initialize(gamestate, index)
    table.insert(gamestate.entities, self)
    self.index = index
    self.tech = Tech:new(self)
    self.launchers = {}
    self.selected_launcher_idx = nil
    self.gamestate = gamestate
    self.aim_dir = Vec(0,-1)
    self.launch_held_seconds = 0
    self.launch_power_per_second = k_launch_default_power
    self.selected_projectile_id = k_projectile_id.bomb
    self.selected_building_instance = nil

    self.input = baton.new(self:_defineInput())
end

function Player:getAim()
    -- Only allow one user to query the mouse so one mouse doesn't control two
    -- keyboard player's aim.
    if self.input:getActiveDevice() == 'kbm' and self:_isMouseUser() then
        local launch = self:_getLauncher()
        local pos = Vec()
        if launch then
            pos = Vec(launch.collider:getPosition())
        end
        local dir = Vec(screener.getMousePosition()) - pos
        return dir:normalizeInplace()
    elseif self.input:getActiveDevice() == 'joy' then
        local x,y = self.input:get('aim')
        return Vec(x,y)
    else
        -- no active device
        return Vec()
    end
end

function Player:_isMouseUser()
    return self.index == k_mouse_player_id
end

function Player.joystickAdded(gamestate, joystick)
    print('joystickAdded', joystick)
    -- TODO: bind a joystick if we don't have one.
end
    
function Player:_defineInput()
    local input = moretable.append_recursive(self:_defineGamepadInput(), self:_defineKeyboardInput())
    return input
end

function Player:_defineKeyboardInput()
    if self.index == 1 then
        return {
            controls = {
                fire = { 'key:space', 'mouse:1' },
                cycle_projectile_prev = { 'key:w' },
                left = { 'key:a' },
                cycle_projectile_next = { 'key:s' },
                right = { 'key:d' },
                cycle_launcher_left = { 'key:q' },
                cycle_launcher_right = { 'key:e', 'mouse:2' },
                mod_normal = { 'key:1' },
                mod_bouncy = { 'key:2' },
                mod_boosty = { 'key:3' },
                mod_sticky = { 'key:4' },
            }
        }

    else
        return {
            controls = {
                fire = { 'key:rctrl' },
                cycle_projectile_prev = { 'key:up' },
                left = { 'key:left' },
                cycle_projectile_next = { 'key:down' },
                right = { 'key:right' },
                cycle_launcher_left = { 'key:[' },
                cycle_launcher_right = { 'key:]' },
                mod_normal = { 'key:7' },
                mod_bouncy = { 'key:8' },
                mod_boosty = { 'key:9' },
                mod_sticky = { 'key:0' },
            }
        }
    end
end

function Player:_defineGamepadInput()
    local joystick_id
    if self.index == k_gamepad_player_id then
        joystick_id = 1
    else
        joystick_id = 2
    end
    return {
        controls = {
            fire = { 'button:rightshoulder' },
            aim_left = {'axis:leftx-'},
            aim_right = {'axis:leftx+'},
            aim_up = {'axis:lefty-'},
            aim_down = {'axis:lefty+'},
            cycle_launcher_right = { 'button:leftshoulder', 'button:dpright' },
            cycle_projectile_prev = { 'button:dpup' },
            cycle_projectile_next = { 'button:dpdown' },
            cycle_launcher_left = { 'button:dpleft' },
            mod_normal = { 'button:a' },
            mod_bouncy = { 'button:x' },
            mod_boosty = { 'button:y' },
            mod_sticky = { 'button:b' },
        },
        pairs = {
            aim = {'aim_left', 'aim_right', 'aim_up', 'aim_down'}
        },
        deadzone = 0.25,
        joystick = love.joystick.getJoysticks()[joystick_id],
    }

end

function Player:_isPressed(cmd)
    return self.input:pressed(cmd)
end

function Player:_isHeld(cmd)
    return self.input:down(cmd)
end

local function _rotateAim(dt, aim, direction)
    local angle = lume.angle(0,0, aim.x, aim.y)
    angle = angle + math.pi * direction * dt
    return Vec(lume.vector(angle, 1))
end

function Player:update(dt, gamestate)
    self.input:update()
    local aim = self:getAim()
    if moremath.isApproxZero(aim.x) and moremath.isApproxZero(aim.x) then
        aim = self.aim_dir
    end

    local launch = self:_getLauncher()
    if launch then
        launch:parkArm()
    end

    if self.selected_building_instance and self.selected_building_instance.techEffect == Tech.Effects.Boosty and self:_isPressed('fire') then
        self.selected_building_instance.projectile:boost()
    elseif  self:_isHeld('fire') and launch and launch.can_fire then
        self.launch_held_seconds = self.launch_held_seconds + dt
        self.launch_held_seconds = lume.clamp(self.launch_held_seconds, 0, k_launch_maximum_held_seconds)
    elseif self:_isPressed('fire') then
        self.launch_held_seconds = 0
    elseif self.launch_held_seconds > k_launch_minimum_held_seconds then
        self:_fire()
        self.launch_held_seconds = 0
    elseif self:_isPressed('cycle_launcher_left') then
        self:_cycleLauncher(-1)
    elseif self:_isPressed('cycle_launcher_right') then
        self:_cycleLauncher(1)
    elseif self:_isPressed('cycle_projectile_prev') then
        self:_cycleProjectile(-1)
    elseif self:_isPressed('cycle_projectile_next') then
        self:_cycleProjectile(1)
    elseif self:_isPressed('mod_normal') then
        self.tech:selectEffect(Tech.Effects.Basic)
    elseif self:_isPressed('mod_bouncy') then
        self.tech:selectEffect(Tech.Effects.Bouncy)
    elseif self:_isPressed('mod_boosty') then
        self.tech:selectEffect(Tech.Effects.Boosty)
    elseif self:_isPressed('mod_sticky') then
        self.tech:selectEffect(Tech.Effects.Sticky)
    elseif self:_isHeld('left') then
        aim = _rotateAim(dt, aim, -1)
    elseif self:_isHeld('right') then
        aim = _rotateAim(dt, aim, 1)
    end

    self.aim_dir = aim
    if launch then
        launch:poseArm(self.aim_dir)
    end
end

local function _getLaunchStart(launch, aim_dir)
    return Vec(launch.collider:getPosition()) + aim_dir * k_launch_offset
end

function Player:_calcLaunchPower()
    local sec = self.launch_held_seconds - k_launch_minimum_held_seconds
    local intensity = k_launch_minimum_intensity + sec / (k_launch_maximum_held_seconds - k_launch_minimum_held_seconds)
    local pow = intensity * self.launch_power_per_second
    return pow, intensity
end

function Player:_fire()
    local launch = self:_getLauncher()
    if launch then
        local start = _getLaunchStart(launch, self.aim_dir)
        -- See where things are spawned on launch
        --~ self.gamestate.debug_draw_fn = function()
        --~     love.graphics.circle('fill', start.x, start.y, 10)
        --~ end
        local SelectedProjectile = k_projectile_id_to_class[self.selected_projectile_id]
        launch:fire(SelectedProjectile)
        local dot = self.aim_dir:dot(Vec(1,0))
        local launch_params = {}
        launch_params.direction = dot > 0 and 1 or -1
        launch_params.techEffect = self.tech.selectedEffect
        local projectile = SelectedProjectile:new(self.gamestate, self, start.x, start.y, launch_params)
        local power = self:_calcLaunchPower()
        local impulse = self.aim_dir * power
        projectile.collider:applyLinearImpulse(impulse:unpack())
        self.selected_building_instance = projectile
        self.selected_building_type_id = self.selected_projectile_id
    end
end

function Player:_cycleLauncher(direction)
    self.selected_launcher_idx = moretable.circular_index_number(#self.launchers, self.selected_launcher_idx + direction)
    self:clearBuildingSelection()
end

function Player:_cycleProjectile(direction)
    local idx = self.selected_projectile_id
    self.selected_projectile_id = moretable.circular_index_number(#k_projectile_id_to_name, idx + direction)
    print("switched to", k_projectile_id_to_name[self.selected_projectile_id])
end

function Player:notifyDestroyed(ent)
    -- same behavior
    self:markBuildingStabilized(ent)
end
function Player:markBuildingStabilized(projectile)
    if self.selected_building_instance == projectile then
        self:clearBuildingSelection()
    end
end
function Player:clearBuildingSelection()
    self.selected_building_instance = nil
    self.selected_building_type_id = nil
end

function Player:draw()
    local launch = self:_getLauncher()
    if launch then
        local screen_w, screen_h = screener.getDimensions()

        local pad = 25
        local bottom = screen_h - pad
        pad = pad + 5
        local draw_x
        if self.index == 1 then
            draw_x = pad
        else
            draw_x = screen_w - pad
        end

        -- Current projectile selector
        love.graphics.setColor(self:getColour())
        
        local selected = k_projectile_id_to_name[self.selected_projectile_id]
        local sprite = self.gamestate.art[selected]
        local w,h = sprite:getDimensions()
        love.graphics.draw(sprite,
            draw_x, bottom,
            nil,
            0.5, 0.5,
            w/2, h/2)


        -- Launcher power
        if self.launch_held_seconds > k_launch_minimum_held_seconds then
            local power,intensity = self:_calcLaunchPower()
            local tinted = {255, power, 0}
            love.graphics.setColor(unpack(tinted))
            local to_edge_of_barrel = self.aim_dir * 13
            local start = _getLaunchStart(launch, self.aim_dir) + to_edge_of_barrel
            local target = start + self.aim_dir * 50 * intensity
            love.graphics.setLineWidth(5)
            love.graphics.line(start.x, start.y, target.x, target.y)
        end
    end

    local selected_building
    if self.selected_building_instance then
        selected_building = self.selected_building_instance
    elseif launch then
        selected_building = launch
    end

    -- Launcher selection
    if selected_building and selected_building.collider then
        local centre = Vec(selected_building.collider:getPosition())
        love.graphics.setLineWidth(1)
        love.graphics.setColor(self:getColour())
        love.graphics.circle('line', centre.x, centre.y, selected_building.projectile.radius * 2.1)
    end

    self.tech:drawResourceUI()
end

function Player:addLauncher(launcher)
    table.insert(self.launchers, launcher)
    -- Always select new launchers
    self.selected_launcher_idx = #self.launchers
end

function Player:removeLauncher(launcher)
    local idx = pl_table.find(self.launchers, launcher)
    if idx == nil then
        return
    end
    table.remove(self.launchers, idx)
    if idx == self.selected_launcher_idx then
        self.selected_launcher_idx = 1
    elseif idx < self.selected_launcher_idx then
        -- We removed one before, so move up to keep the same one selected.
        self.selected_launcher_idx = self.selected_launcher_idx + 1
    end

    if #self.launchers == 0 then
        self.gamestate:onLose(self)
    end
end

function Player:_getLauncher()
    local launch = self.launchers[self.selected_launcher_idx]
    if launch and launch:hasStabilized() then
        return launch
    end
end

function Player:getColour()
    return colorizer.getColour(self.index)
end

return Player
