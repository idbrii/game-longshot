local M = require("moses.moses")
local Vec = require('hump.vector')
local class = require("astray.MiddleClass")

-- A thing that might be launched out of a Launcher.
local Projectile = class('Projectile')

Projectile.collision_class = 'Building'

function Projectile:initialize(gamestate, owner, x, y, radius)
    table.insert(gamestate.entities, self)
    self.gamestate = gamestate
    --~ print("Projectile:", "creating at", x, y)
    self.owner = owner
    self.radius = radius or 10
    self.collider = gamestate.world:newCircleCollider(x, y, self.radius)
    self.collider:setRestitution(0.1)
    self.collider:setCollisionClass(Projectile.collision_class)
    self.has_stabilized = false
    self.tint = 1
end

function Projectile:update()
    local wall = 'Block'
    if self.collider:enter(wall) then
        local collision_data = self.collider:getEnterCollisionData(wall)
        self:onHitWall(collision_data)
    end
end

function Projectile:draw()
    local cx,cy = self.collider:getPosition()
    local tinted = M.map({self.owner:getColour()}, function(v,k)
        return v * self.tint
    end)
    love.graphics.setColor(unpack(tinted))
    local style = 'line'
    if self.has_stabilized then
        style = 'fill'
    end
    love.graphics.circle(style, cx, cy, self.radius)
end

function Projectile:onHitWall(collision_data)
    self.has_stabilized = true
    local pos = Vec(self.collider:getPosition())
    local x,y = collision_data.collider:getPosition()
    local hit_ground = y > pos.y
    if hit_ground then
        self.collider:setLinearVelocity(0, 0)
        self.collider:setType('static')
        self.collider:setLinearDamping(0.1)
        self.has_stabilized = true
        self.tint = 1
    end
end

return Projectile
