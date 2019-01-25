local Barracks = require('barracks')
local Bomb = require('bomb')
local Launcher = require('launcher')
local M = require("moses.moses")
local Resourcer = require('resourcer')
local Tech = require('tech')
local Vec = require('hump.vector')
local class = require('astray.MiddleClass')
local colorizer = require('colorizer')
local lume = require('rxi.lume')
local moremath = require('moremath')
local moretable = require('moretable')
local pl_table = require('pl.tablex')
local wf = require('windfield')


local Player = class('Player')

local k_mouse_player_id = 1
local k_gamepad_player_id = 2
local current_gamepad_player_id = nil

local k_launch_offset = 50
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




local function snapToDeadzone(input)
    local deadzone = 0.2
    if math.abs(input) < deadzone then
        return 0
    end
    return input
end

function Player:initialize(gamestate, index)
    table.insert(gamestate.entities, self)
    self.index = index
    self.tech = Tech:new(self)
    self.input_prefix = string.format('p%i_', index)
    self.launchers = {}
    self.selected_launcher_idx = nil
    self.gamestate = gamestate
    self.aim_dir = Vec(0,-1)
    self.launch_held_seconds = 0
    self.launch_power_per_second = k_launch_default_power
    self.selected_projectile_id = k_projectile_id.bomb

    if self:_isMouseUser() then
        self.getAim = function(this)
            local launch = self:_getLauncher()
            local pos = Vec()
            if launch then
                pos = Vec(launch.collider:getPosition())
            end
            local dir = Vec(love.mouse.getPosition()) - pos
            return dir:normalizeInplace()
        end
    else
        assert(self.index == k_gamepad_player_id)
        self.getAim = function(this)
            if self.index == current_gamepad_player_id then
                local x = self.gamestate.input.joysticks[1]:getGamepadAxis('leftx')
                local y = self.gamestate.input.joysticks[1]:getGamepadAxis('lefty')
                x = snapToDeadzone(x)
                y = snapToDeadzone(y)
                return Vec(x,y)
            else 
                return Vec()
            end
        end
    end
end

function Player:_isMouseUser()
    return self.index == k_mouse_player_id
end

function Player.defineKeyboardInput(gamestate)
    local inp = gamestate.input
    inp:bind('space', 'p1_fire')
    inp:bind('mouse1','p1_fire')
    inp:bind('w',     'p1_cycle_projectile_prev')
    inp:bind('a',     'p1_left')
    inp:bind('s',     'p1_cycle_projectile_next')
    inp:bind('d',     'p1_right')
    inp:bind('q',     'p1_cycle_launcher_left')
    inp:bind('e',     'p1_cycle_launcher_right')
    inp:bind('mouse2','p1_cycle_launcher_right')
    inp:bind('1',     'p1_mod_normal')
    inp:bind('2',     'p1_mod_bouncy')
    inp:bind('3',     'p1_mod_boosty')
    inp:bind('4',     'p1_mod_sticky')

    inp:bind('rctrl', 'p2_fire')
    inp:bind('up',    'p2_cycle_projectile_prev')
    inp:bind('left',  'p2_left')
    inp:bind('down',  'p2_cycle_projectile_next')
    inp:bind('right', 'p2_right')
    inp:bind('[',     'p2_cycle_launcher_left')
    inp:bind(']',     'p2_cycle_launcher_right')
    inp:bind('7',     'p2_mod_normal')
    inp:bind('8',     'p2_mod_bouncy')
    inp:bind('9',     'p2_mod_boosty')
    inp:bind('0',     'p2_mod_sticky')
end

function Player.defineGamepadInput(gamestate)
    current_gamepad_player_id = k_gamepad_player_id

    local inp = gamestate.input
    local gamepad_player = string.format('p%i', k_gamepad_player_id)
    inp:bind('r1',      gamepad_player ..'_fire')
    inp:bind('l1',      gamepad_player ..'_cycle_launcher_right')
    inp:bind('dpup',    gamepad_player ..'_cycle_projectile_prev')
    inp:bind('dpdown',  gamepad_player ..'_cycle_projectile_next')
    inp:bind('dpleft',  gamepad_player ..'_cycle_launcher_left')
    inp:bind('dpright', gamepad_player ..'_cycle_launcher_right')
    inp:bind('fdown',   gamepad_player ..'_mod_normal')
    inp:bind('fleft',   gamepad_player ..'_mod_bouncy')
    inp:bind('fup',     gamepad_player ..'_mod_boosty')
    inp:bind('fright',  gamepad_player ..'_mod_sticky')
end

function Player:_isPressed(cmd)
    local player_cmd = self.input_prefix .. cmd
    return self.gamestate.input:pressed(player_cmd)
end

function Player:_isHeld(cmd)
    local player_cmd = self.input_prefix .. cmd
    return self.gamestate.input:held(player_cmd)
end

local function _rotateAim(dt, aim, direction)
    local angle = lume.angle(0,0, aim.x, aim.y)
    angle = angle + math.pi * direction * dt
    return Vec(lume.vector(angle, 1))
end

function Player:update(dt, gamestate)
    local aim = self:getAim()
    if moremath.isApproxZero(aim.x) and moremath.isApproxZero(aim.x) then
        aim = self.aim_dir
    end

    local launch = self:_getLauncher()
    if launch then
        launch:parkArm()
    end

    if     self:_isHeld('fire') and launch and launch.can_fire then
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
    local intensity = sec / (k_launch_maximum_held_seconds - k_launch_minimum_held_seconds)
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
        local dot = self.aim_dir:dot(Vec(0,1))
        local launch_params = {
            direction = dot > 0 and 1 or -1,
            techEffect = self.tech.selectedEffect,
        }
        local projectile = SelectedProjectile:new(self.gamestate, self, start.x, start.y, launch_params)
        local power = self:_calcLaunchPower()
        local impulse = self.aim_dir * power
        projectile.collider:applyLinearImpulse(impulse:unpack())
    end
end

function Player:_cycleLauncher(direction)
    self.selected_launcher_idx = moretable.circular_index_number(#self.launchers, self.selected_launcher_idx + direction)
end

function Player:_cycleProjectile(direction)
    local idx = self.selected_projectile_id
    self.selected_projectile_id = moretable.circular_index_number(#k_projectile_id_to_name, idx + direction)
    print("switched to", k_projectile_id_to_name[self.selected_projectile_id])
end

function Player:draw()
    local launch = self:_getLauncher()
    if launch then
        local screen_w, screen_h = love.graphics.getWidth(), love.graphics.getHeight()

        local pad = 25
        local bottom = screen_h - pad
        pad = pad + 5
        local draw_x
        if self.index == 1 then
            draw_x = pad
        else
            draw_x = screen_w - pad
        end

        -- Current projectile
        love.graphics.setColor(self:getColour())
        
        local selected = k_projectile_id_to_name[self.selected_projectile_id]
        local sprite = self.gamestate.art[selected]
        local w,h = sprite:getDimensions()
        love.graphics.draw(sprite,
            draw_x, bottom,
            nil,
            0.5, 0.5,
            w/2, h/2)


        -- Launcher selection
        local centre = Vec(launch.collider:getPosition())
        love.graphics.setLineWidth(1)
        love.graphics.circle('line', centre.x, centre.y, launch.radius * 2.1)

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
