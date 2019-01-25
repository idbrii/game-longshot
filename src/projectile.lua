local M = require("moses.moses")
local Vec = require('hump.vector')
local class = require("astray.MiddleClass")
local moremath = require('moremath')
local pl_table = require('pl.tablex')
local pretty = require("pl.pretty")
local tuning = require('tuning')
local Tech = require("tech")

-- A thing that might be launched out of a Launcher.
local Projectile = class('Projectile')

Projectile.collision_class = 'Building'

function Projectile:initialize(entity, owner, x, y, radius, image, techEffect, isDeployable)
    self.entity = entity
    self.gamestate = entity.gamestate
    --~ print("Projectile:", "creating at", x, y)
    self.owner = owner
    self.sprite = image
    self.radius = radius or 10
    self.collider = self.gamestate.world:newCircleCollider(x, y, self.radius)
    self.techEffect = techEffect
    self.isDeployable = isDeployable
    self.collider:setRestitution(techEffect.restitution)
    self.collider:setCollisionClass(Projectile.collision_class)
    self.has_stabilized = false
    self.tint = 1
    self.onWallActivate_cb = {}
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
        self:onHitWall(collision_data, collision_data.contact:getPositions())
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

function Projectile:isMotionless(minSpeed)
    local vel = Vec(self.collider:getLinearVelocity())
    local speed2 = vel:len2()
    if minSpeed then
        return speed2 < minSpeed
    else
        return moremath.isApproxZero(speed2)
    end
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
        1,1,
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
function round(x)
    return x>=0 and math.floor(x+0.5) or math.ceil(x-0.5)
end
function Projectile:wallActivation(collision_data, cx, cy)
    local attachmentAngle
    if self.isDeployable then
        self.collider:setLinearVelocity(0, 0)
        self.collider:setType('static')
        self.collider:setLinearDamping(0.1)
        self.has_stabilized = true
        self.owner:markBuildingStabilized(self.entity)
        self.tint = 1
        local px, py = self.collider:getPosition()
        local angle = math.atan2(cx-px,cy-py)
        attachmentAngle = round(angle * 2) / 2
    end
    for i,listener in ipairs(self.onWallActivate_cb) do
        listener(self, collision_data, attachmentAngle)
    end
end

function Projectile:onHitWall(collision_data, ...)
    local pos = Vec(self.collider:getPosition())
    local x,y = collision_data.collider:getPosition()
    local hit_ground = y > pos.y and self:_checkForGround()
    if self.techEffect == Tech.Effects.Basic then
        if self.isDeployable then
            if hit_ground then
                self:wallActivation(collision_data, ...)
            end
        else
            self:wallActivation(collision_data, ...)
        end
    elseif self.techEffect == Tech.Effects.Bouncy then
        if self:isMotionless(tuning.projectile.minSpeed) then
            if self.isDeployable then
                if hit_ground then
                    self:wallActivation(collision_data, ...)
                end
            else
                self:wallActivation(collision_data, ...)
            end
        end
    elseif self.techEffect == Tech.Effects.Sticky then
        self:wallActivation(collision_data, ...)
    else
        print("WARNING: unknonwn tech effect", self.techEffect)
    end
end

function Projectile:onHitBuilding(collision_data)
    if self.has_stabilized and not self.isDeployable then
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
