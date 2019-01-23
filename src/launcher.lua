local class = require("astray.MiddleClass")

local Launcher = class('Launcher')

Launcher.collision_class = 'Building'

function Launcher:initialize(gamestate, owner, x, y)
    table.insert(gamestate.entities, self)
    --~ print("Launcher:", "creating at", x, y)
    self.radius = 10
    self.collider = gamestate.world:newCircleCollider(x, y, self.radius)
    self.collider:setRestitution(0.8)
    self.collider:setCollisionClass(Launcher.collision_class)
    self.collider:applyLinearImpulse(500, 500)
    self.owner = owner
    self.owner:addLauncher(self)
end

function Launcher:update()
end
function Launcher:draw()
    local cx,cy = self.collider:getPosition()
    love.graphics.setColor(self.owner:getColour())
    love.graphics.circle('fill', cx, cy, self.radius)
end

return Launcher
