local M = require("moses.moses")
local Vec = require('hump.vector')
local class = require("astray.MiddleClass")
local moremath = require('moremath')
local pl_table = require('pl.tablex')
local pretty = require("pl.pretty")
local tuning = require('tuning')

-- A thing that might be launched out of a Launcher.
local Projectile = class('Projectile')

Projectile.collision_class = 'Building'

function Projectile:initialize(gamestate, owner, x, y, radius, image, techEffect)
    self.gamestate = gamestate
    --~ print("Projectile:", "creating at", x, y)
    self.owner = owner
    self.sprite = image
    self.radius = radius or 10
    self.collider = gamestate.world:newCircleCollider(x, y, self.radius)
    self.techEffect = techEffect
    self.collider:setRestitution(techEffect.restitution)
    self.collider:setCollisionClass(Projectile.collision_class)
    self.has_stabilized = false
    self.tint = 1
    self.onHitWall_cb = {}
    self.onHitBuilding_cb = {}
    self.triggerdeath_cb = nil
    self.seconds_unstable = 0
    self.seconds_motionless = 0
end

function Projectile:die()
    self.collider:destroy()
    self.collider = nil
end

function Projectile:update(dt)
    if not self.has_stabilized then
        self.seconds_unstable = self.seconds_unstable + dt
        if self:isMotionless() then
            self.seconds_motionless = self.seconds_motionless + dt
        else
            self.seconds_motionless = 0
        end
        if self.seconds_unstable > tuning.timer.projectile.max_lifetime then
            print('dying from old age')
            self.triggerdeath_cb()
            return
        elseif self.seconds_motionless > tuning.timer.projectile.max_idle_lifetime then
            print('dying from idle hands')
            self.triggerdeath_cb()
            return
        end
    end

    local wall = 'Block'
    if self.collider:enter(wall) then
        local collision_data = self.collider:getEnterCollisionData(wall)
        self:onHitWall(collision_data)
    elseif self.collider:enter(Projectile.collision_class) then
        local collision_data = self.collider:getEnterCollisionData(Projectile.collision_class)
        if not self.source_launcher_hit then
            self.source_launcher_hit = collision_data.collider
        elseif self.has_cleared_launcher or self:isMotionless() then
            self.has_cleared_launcher = true
            self:onHitBuilding(collision_data)
        elseif self.source_launcher_hit ~= collision_data.collider then
            self.has_cleared_launcher = true
        end
        self.has_cleared_launcher = true
    else
        self.has_cleared_launcher = true
    end
end

function Projectile:isMotionless()
    local vel = Vec(self.collider:getLinearVelocity())
    local speed2 = vel:len2()
    return moremath.isApproxZero(speed2)
end

function Projectile:draw()
    local cx,cy = self.collider:getPosition()
    local tinted = M.map({self.owner:getColour()}, function(v,k)
        return v * self.tint
    end)
    love.graphics.setColor(unpack(tinted))
    local w,h = self.sprite:getDimensions()
    love.graphics.draw(self.sprite,
        cx,cy,
        nil,
        0.5, 0.5,
        w/2, h/2)
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
    if self.techEffect.activateOnImpact then
        return
    end
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

function Projectile:onHitBuilding(collision_data)
    if self.has_stabilized then
        -- We don't do anything if we're stable. They should be destroyed.
        return
    end

    local target = collision_data.collider:getObject()
    if target.damagable then
        target.damagable:takeDamage(tuning.damage_dealer.launcher)
    else
        print("Why doesn't this thing have a damagable?", target)
        --~ pretty.dump(target)
    end

    for i,listener in ipairs(self.onHitBuilding_cb) do
        listener(self, collision_data)
    end
end

return Projectile
