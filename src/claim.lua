local class = require("astray.MiddleClass")
local pretty = require("pl.pretty")


local Claim = class("Claim")

function Claim:initialize(gamestate, x, y, resourcer, generation)
    self.gamestate = gamestate
    self.x = x
    self.y = y
    self.resourcer = resourcer
    self.generation = generation
    table.insert(gamestate.entities, self)
end

function Claim:owner()
    return self.resourcer.owner
end


function Claim:update()
end

function Claim:draw()
    local size = self.gamestate.map.tile_size;
    local x = self.gamestate.map:toScreenPosSingle(self.x)
    local y = self.gamestate.map:toScreenPosSingle(self.y)
    local r, g, b = self:owner():getColour()
    love.graphics.setColor(r, g, b, 0.5)
    love.graphics.rectangle('fill', x - size / 2, y - size / 2, size, size)
end

return Claim