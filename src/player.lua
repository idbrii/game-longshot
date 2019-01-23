local Launcher = require('launcher')
local Vec = require('hump.vector')
local class = require('astray.MiddleClass')
local lume = require('rxi.lume')
local moremath = require('moremath')
local moretable = require('moretable')
local pl_table = require('pl.tablex')
local wf = require('windfield')


local Player = class('Player')

local k_mouse_player_id = 1
local k_gamepad_player_id = 2
local current_gamepad_player_id = nil

local k_launch_offset = 10

function Player:initialize(gamestate, index)
    table.insert(gamestate.entities, self)
    self.index = index
    self.input_prefix = string.format('p%i_', index)
    self.launchers = {}
    self.selected_launcher_idx = nil
    self.gamestate = gamestate
    self.aim_dir = Vec()
    self.launch_power = 50

    if self:_isMouseUser() then
        self.getAim = function(this)
            local launch = self:_getLauncher()
            local pos = Vec()
            if launch then
                pos = Vec(launch.collider:getPosition())
            end
            local dir = pos - Vec(love.mouse.getPosition())
            return dir:normalizeInplace()
        end
    else
        assert(self.index == k_gamepad_player_id)
        self.getAim = function(this)
            if self.index == current_gamepad_player_id then
                local x = self.gamestate.input.joysticks[1]:getGamepadAxis('leftx')
                local y = self.gamestate.input.joysticks[1]:getGamepadAxis('lefty')
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
    inp:bind('w',     'p1_up')
    inp:bind('a',     'p1_left')
    inp:bind('s',     'p1_down')
    inp:bind('d',     'p1_right')
    inp:bind('q',     'p1_cycle_launcher_left')
    inp:bind('e',     'p1_cycle_launcher_right')
    inp:bind('1',     'p1_mod_normal')
    inp:bind('2',     'p1_mod_bouncy')
    inp:bind('3',     'p1_mod_boosty')
    inp:bind('4',     'p1_mod_sticky')

    inp:bind('rctrl', 'p2_fire')
    inp:bind('up',    'p2_up')
    inp:bind('left',  'p2_left')
    inp:bind('down',  'p2_down')
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
    inp:bind('fdown',         gamepad_player ..'_fire')
    inp:bind('dpup',          gamepad_player ..'_up')
    inp:bind('dpleft',        gamepad_player ..'_left')
    inp:bind('dpdown',        gamepad_player ..'_down')
    inp:bind('dpright',       gamepad_player ..'_right')
    inp:bind('leftshoulder',  gamepad_player ..'_cycle_launcher_left')
    inp:bind('rightshoulder', gamepad_player ..'_cycle_launcher_right')
    inp:bind('back',          gamepad_player ..'_mod_normal')
    inp:bind('fleft',         gamepad_player ..'_mod_bouncy')
    inp:bind('fup',           gamepad_player ..'_mod_boosty')
    inp:bind('fright',        gamepad_player ..'_mod_sticky')
end

function Player:_isPressed(cmd)
    local player_cmd = self.input_prefix .. cmd
    return self.gamestate.input:pressed(player_cmd)
end

function Player:_isHeld(cmd)
    local player_cmd = self.input_prefix .. cmd
    return self.gamestate.input:held(player_cmd)
end

function Player:update()
    local aim = self:getAim()
    if moremath.isApproxZero(aim.x) and moremath.isApproxZero(aim.x) then
        aim = self.aim_dir
    end

    if     self:_isPressed('fire') then
        self:_fire()
    elseif self:_isPressed('cycle_launcher_left') then
        self:_cycleLauncher(-1)
    elseif self:_isPressed('cycle_launcher_right') then
        self:_cycleLauncher(1)
    elseif self:_isPressed('mod_normal') then
    elseif self:_isPressed('mod_bouncy') then
    elseif self:_isPressed('mod_boosty') then
    elseif self:_isPressed('mod_sticky') then
    elseif self:_isPressed('up') then
    elseif self:_isPressed('down') then
    elseif self:_isHeld('left') then
        local delta = Vec(lume.vector(-5, 1))
        aim = aim + delta
    elseif self:_isHeld('right') then
        local delta = Vec(lume.vector(5, 1))
        aim = aim + delta
    end

    self.aim_dir = aim
end

function Player:_fire()
    local launch = self:_getLauncher()
    if launch then
        local start = Vec(launch.collider:getPosition()) + self.aim_dir * k_launch_offset
        local projectile = Launcher:new(self.gamestate, self, start.x, start.y)
        local impulse = self.aim_dir * self.launch_power
        projectile.collider:applyLinearImpulse(impulse:unpack())
    end
end

function Player:_cycleLauncher(direction)
    self.selected_launcher_idx = moretable.circular_index_number(#self.launchers, self.selected_launcher_idx + direction)
end

function Player:draw()
    -- Draw player UI here?

    local launch = self:_getLauncher()
    if launch then
        local start = Vec(launch.collider:getPosition())
        love.graphics.setColor(self:getColour())
        love.graphics.circle('line', start.x, start.y, launch.radius * 1.3)
    end
end


function Player:addLauncher(launcher)
    table.insert(self.launchers, launcher)
    -- Always select new launchers
    self.selected_launcher_idx = #self.launchers
end

function Player:_getLauncher()
    return self.launchers[self.selected_launcher_idx]
end

function Player:getColour()
    if self.index == 1 then
        return 0, 255, 0
    else
        return 255, 0, 0
    end
end

return Player
