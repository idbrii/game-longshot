local M = require("moses.moses")
local Projectile = require('projectile')
local Vec = require('hump.vector')

local Launcher = Projectile:subclass('Launcher')

Launcher.collision_class = 'Building'

function Launcher:initialize(gamestate, owner, x, y)
    Projectile.initialize(self, gamestate, owner, x, y)
    self.collider:setCollisionClass(Launcher.collision_class)
    self.collider:applyLinearImpulse(500, 500)
    self.owner:addLauncher(self)
    self.tint = 0.1
end

function Launcher:update()
    Projectile.update(self)
end
function Launcher:draw()
    Projectile.draw(self)
end

function Launcher:onHitWall(collision_data)
    Projectile.onHitWall(self, collision_data)
    -- disable this code for now
    -- it's causing 'Attempt to use destroyed contact.'
    self.has_stabilized = true
    if self.has_stabilized then
        return
    end
    local pos = Vec(self.collider:getPosition())
    local hit_points = {collision_data.contact:getPositions()}
    print(hit_points)
    local lowest = M.min(M.select(hit_points, M.isNumber))
    --~ for i,pt in ipairs(hit_points) do
    --~     if pt.y < lowest then
    --~         lowest = pt.y
    --~     end
    --~ end
    local hit_ground = lowest < pos.y
    if hit_ground then
        self.collider:setLinearVelocity(0, 0)
        self.collider:setType('static')
        self.has_stabilized = true
        self.tint = 1
    end
end

return Launcher
