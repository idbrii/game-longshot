local class = require("astray.MiddleClass")

-- A thing that might be launched out of a Launcher.
local Projectile = class('Projectile')

Projectile.collision_class = 'Building'

function Projectile:initialize(gamestate, owner, x, y)
    table.insert(gamestate.entities, self)
    --~ print("Projectile:", "creating at", x, y)
    self.owner = owner
    self.radius = 10
    self.collider = gamestate.world:newCircleCollider(x, y, self.radius)
    self.collider:setRestitution(0.8)
end

function Projectile:update()
end

function Projectile:draw()
    local cx,cy = self.collider:getPosition()
    love.graphics.setColor(self.owner:getColour())
    love.graphics.circle('fill', cx, cy, self.radius)
end

return Projectile
