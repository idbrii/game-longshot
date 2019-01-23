local pl_table = require('pl.tablex')
local class = require('astray.MiddleClass')
local wf = require('windfield')

local Player = class('Player')

function Player:initialize(gamestate, index)
    self.index = index
    self.launchers = {}
    self.selected_launcher_idx = nil
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
