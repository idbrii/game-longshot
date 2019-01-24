local class = require("astray.MiddleClass")
local pretty = require("pl.pretty")
local Entity = require('entity')
local tablex = require("pl.tablex")
local utils = require("pl.utils")
local Damagable = require("damagable")

local images = {
    walk1=love.graphics.newImage("assets/sprites/soldier/walk1.png"),
    walk2=love.graphics.newImage("assets/sprites/soldier/walk2.png"),
    climb1=love.graphics.newImage("assets/sprites/soldier/climb1.png"),
    climb2=love.graphics.newImage("assets/sprites/soldier/climb2.png"),
    fall1=love.graphics.newImage("assets/sprites/soldier/fall1.png"),
    attack1=love.graphics.newImage("assets/sprites/soldier/attack1.png"),
    attack2=love.graphics.newImage("assets/sprites/soldier/attack2.png")
}
local imgAnim1= {
    images.walk1,
    images.fall1,
    images.climb1,
    images.attack1
}

local imgAnim2= {
    images.walk2,
    images.fall1,
    images.climb2,
    images.attack2
}
local states = {
    walking=1,
    falling=2,
    climbing=3,
    combat=4, -- ONLY used for animation, self.state will never equal this!
}

local Soldier = Entity:subclass("Soldier")

function Soldier:initialize(gamestate, owner, x, y, direction)
    Entity.initialize(self, gamestate, owner)
    self.targetWalkSpeed = 80
    self.walkBounceImpulse = -40
    self.climbSpeed = 50
    self.climbLedgeVault = 100
    self.ledgeVaultTimeout = 0.1
    self.stuckTimeout = 2.5
    self.attackDamage = 25
    self.stepRate = 0.75
    self.combatPoseTime = 0.4
    self.damagable = Damagable:new(100, utils.bind1(self.die, self))
    self.owner = owner
    self.direction = direction
    self.collider = gamestate.world:newCircleCollider(x, y, 10)
    self.collider:setObject(self)
    self.collider:setRestitution(0.1)
    self.collider:setCollisionClass("SoldiersP" .. self.owner.index)
    self.state = states.falling
    self.scheduleFall = nil
    self.lastCollision = nil
    self.spawnedAt = love.timer.getTime()
    self.showCombatPoseUntil = nil
end

function Soldier:shape()
    return self.collider.shapes.main;
end
function Soldier:radius()
    return self:shape():getRadius();
end

function Soldier:walkBounce()
    self.state = states.walking
    local vx = self.collider:getLinearVelocity()
    local xImpulse = self.direction * math.max(self.targetWalkSpeed  - math.abs(vx), 0)
    --print("WALK", xImpulse)
    self.collider:applyLinearImpulse(xImpulse, self.walkBounceImpulse)
end

function Soldier:climb()
    self.state = states.climbing
    --print("CLIMB")
end

function Soldier:dropToWalk()
    self.state = states.walking
    self.collider:setLinearVelocity(0, 0)
end

function Soldier:reverseDirection()
    self.collider:setLinearVelocity(0, 0)
    self.direction = self.direction * -1
    self.state = states.falling
    --print("REVERSE")
end

function Soldier:die()
    Entity.die(self)
    self.collider:destroy()
    self.collider = nil
end

function Soldier:attack(other)
    self.collider:applyLinearImpulse(self.walkBounceImpulse * self.direction, self.walkBounceImpulse)
    self.showCombatPoseUntil = love.timer.getTime() + self.combatPoseTime
    other.damagable:takeDamage(self.attackDamage)
end

function Soldier:update(dt)
    Entity.update(self, dt)
    local ts = love.timer.getTime()
    if self.state == states.climbing then
        if self.lastTouchedClimbingBlock and (ts - self.lastTouchedClimbingBlock) > self.ledgeVaultTimeout then
            self:dropToWalk()
        else
            self.collider:setLinearVelocity(self.direction * self.climbLedgeVault , -self.climbSpeed)
        end

    end

    if self.collider:exit('Block') then
        self.lastTouchedClimbingBlock = ts
    end

    local px, py = self.collider:getPosition()
    local radius = self:radius()
    local leftEdge = px - radius
    local rightEdge = px + radius
    local bottomEdge = py + radius
    local topEdge = py - radius
    if self.collider:enter('Block') then
        self.lastCollisionTs = ts
        local collision = self.collider:getEnterCollisionData('Block')
        local cx, cy = collision.collider:getPosition()
        local didCollideOutsideHrzBounds = cx < leftEdge or cx > rightEdge
        local didCollideAboveFloor = cy > bottomEdge
        local didCollideBelowCeiling = cy < topEdge
        self.lastCollision = collision
        if self.state == states.walking and not didCollideAboveFloor and didCollideOutsideHrzBounds then
            self:climb()
        elseif self.state == states.climbing and not didCollideOutsideHrzBounds then
            if didCollideBelowCeiling then
                self.lastWalkBounce = nil
                self:reverseDirection()
            end
        elseif self.state == states.walking or self.state == states.falling and didCollideAboveFloor then
            self.lastWalkBounce = ts
            self:walkBounce()
        end
    end
    if self.state == states.walking and self.lastWalkBounce and (ts - self.lastWalkBounce) > self.stepRate  then
        self.lastWalkBounce = ts
        self:walkBounce()
    end
    if self.lastCollisionTs and (ts - self.lastCollisionTs) > self.stuckTimeout then
        self:reverseDirection()
        self:walkBounce()
    end

    if self.collider:enter('Building')
            or self.collider:enter('SoldiersP1')
            or self.collider:enter('SoldiersP2') then
        local collision = self.collider:getEnterCollisionData('Building')
                or self.collider:getEnterCollisionData('SoldiersP1')
                or self.collider:getEnterCollisionData('SoldiersP2')
        self.lastCollisionTs = ts
        self.state = states.walking
        local target = collision.collider:getObject()
        -- no idea why we sometimes get collision data without the attached objec
        if target and collision.collider.collision_class ~= self.collider.collision_class then
            self:attack(target)
        --else
        --    print(self.collider.collision_class .. "->" .. collision.collider.collision_class)
        end

    end

    if self.showCombatPoseUntil and ts > self.showCombatPoseUntil then
        self.showCombatPoseUntil = nil
    end

end
function Soldier:draw()
    Entity.draw(self)
    local cx,cy = self.collider:getPosition()
    local r, g, b = self.owner:getColour()
    --debug
    --if self.lastCollision then
    --    local x, y = self.lastCollision.collider:getPosition()
    --    love.graphics.circle('fill', x, y, 3)
    --end
    self.damagable:drawHpBar(5, cx - self:radius(), cy - 20, self:radius() * 2, r, g, b)

    if self.owner.index == 1 then
        love.graphics.setColor(0, 255, 0)
    else
        love.graphics.setColor(255, 0, 0)
    end

    local age = love.timer.getTime() - self.spawnedAt
    local imageMap = (math.floor(age * 5) % 2) == 0 and imgAnim1 or imgAnim2
    local px
    if self.direction == 1 then
        px = cx - 8
    else
        px = cx + 8
    end
    local state = self.showCombatPoseUntil and states.combat or self.state
    love.graphics.draw(imageMap[state],
            px, cy-18, 0, self.direction, 1)
end

return Soldier
