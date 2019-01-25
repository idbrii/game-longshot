local M = require("moses.moses")
local Vec = require('hump.vector')
local class = require("astray.MiddleClass")
local pl_table = require('pl.tablex')

-- A thing that might be launched out of a Launcher.
local Projectile = class('Projectile')

Projectile.collision_class = 'Building'

function Projectile:initialize(gamestate, owner, x, y, radius)
    self.gamestate = gamestate
    --~ print("Projectile:", "creating at", x, y)
    self.owner = owner
    self.radius = radius or 10
    self.collider = gamestate.world:newCircleCollider(x, y, self.radius)
    self.collider:setRestitution(0.1)
    self.collider:setCollisionClass(Projectile.collision_class)
    self.has_stabilized = false
    self.tint = 1
    self.onHitWall_cb = {}
end

function Projectile:die()
    self.collider:destroy()
    self.collider = nil
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
    --~ local style = 'line'
    --~ if self.has_stabilized then
    --~     style = 'fill'
    --~ end
    --~ love.graphics.circle(style, cx, cy, self.radius)
end

function Projectile:_checkForGround()
    local x,y = self.collider:getPosition()
    local pad = self.radius * 0.75
    local offset_down = 5 + self.radius
    local y_check = y + offset_down
    return self:_checkForBlock(x,y, x - pad, y_check)
        or self:_checkForBlock(x,y, x + pad, y_check)
end

function Projectile:_checkForBlock(me_x,me_y, check_x,check_y)
    local hits = self.gamestate.world:queryLine(me_x, me_y, check_x, check_y, { 'Block' })
    return #hits > 0
end

function Projectile:onHitWall(collision_data)
    local pos = Vec(self.collider:getPosition())
    local x,y = collision_data.collider:getPosition()
    local hit_ground = y > pos.y and self:_checkForGround()
    if hit_ground then
        self.collider:setLinearVelocity(0, 0)
        self.collider:setType('static')
        self.collider:setLinearDamping(0.1)
        self.has_stabilized = true
        self.tint = 1
    end

    for i,listener in ipairs(self.onHitWall_cb) do
        listener(self, collision_data)
    end
end

return Projectile
