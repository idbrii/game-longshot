local class = require("astray.MiddleClass")

local Soldier = class("Soldier")

function Soldier:initialize(gamestate, x, y, direction)
    self.gamestate = gamestate
    self.direction = direction
    self.collider = gamestate.world:newCircleCollider(x, y, 10)
    --bouncyness?
    self.collider:setRestitution(0.8)
    self.collider:setCollisionClass("Soldiers")
    table.insert(gamestate.entities, self)
end

function Soldier:update() end
function Soldier:draw()
    local cx,cy = self.collider:getPosition()
    love.graphics.circle('fill', cx, cy, 10)
end

return Soldier