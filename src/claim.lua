local class = require("astray.MiddleClass")
local pretty = require("pl.pretty")
local Entity = require('entity')


local Claim = Entity:subclass("Claim")

function Claim:initialize(gamestate, x, y, resourcer, generation)
    Entity.initialize(self, gamestate, resourcer.owner, 'claim')
    self.x = x
    self.y = y
    self.resourcer = resourcer
    self.generation = generation
    self.owner.tech:addResource(10)
end
function Claim:die()
    Entity.die(self)
    self.owner.tech:deductResource(10)
end

function Claim:update(dt)
    Entity.update(self, dt)
end

function Claim:draw()
    Entity.draw(self)
    local size = self.gamestate.map.tile_size;
    local x = self.gamestate.map:toScreenPosSingle(self.x)
    local y = self.gamestate.map:toScreenPosSingle(self.y)
    local r, g, b = self.owner:getColour()
    love.graphics.setColor(r, g, b, 0.5)
    love.graphics.rectangle('fill', x - size / 2, y - size / 2, size, size)
end

return Claim
