local class = require("astray.MiddleClass")
local pretty = require("pl.pretty")
local tablex = require("pl.tablex")
local utils = require("pl.utils")
local Damagable = require("damagable")

local states = {
    walking=1,
    falling=2,
    climbing=3,
    combat=4,
}

local Soldier = class("Soldier")

function Soldier:initialize(gamestate, owner, x, y, direction)
    self.targetWalkSpeed = 80
    self.walkBounceImpulse = -40
    self.climbSpeed = 50
    self.climbLedgeVault = 100
    self.ledgeVaultTimeout = 0.1
    self.stuckTimeout = 2.5
    self.attackDamage = 25
    self.stepRate = 0.75
    self.damagable = Damagable:new(100, utils.bind1(self.die, self))
    self.gamestate = gamestate
    self.owner = owner
    self.direction = direction
    self.collider = gamestate.world:newCircleCollider(x, y, 10)
    self.collider:setObject(self)
    self.collider:setRestitution(0.1)
    self.collider:setCollisionClass("SoldiersP" .. self.owner.index)
    table.insert(gamestate.entities, self)
    self.state = states.falling
    self.scheduleFall = nil
    self.lastCollision = nil
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
    local idx = tablex.find(self.gamestate.entities, self)
    table.remove(self.gamestate.entities, idx)
    self.collider:destroy()
end

function Soldier:attack(other)
    self.collider:applyLinearImpulse(self.walkBounceImpulse * self.direction, self.walkBounceImpulse)
    other.damagable:takeDamage(self.attackDamage)
end

function Soldier:update()
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

end
function Soldier:draw()
    local cx,cy = self.collider:getPosition()
    local r, g, b = self.owner:getColour()
    love.graphics.setColor(r, g, b, self.damagable:percentHp())
    love.graphics.circle('fill', cx, cy, 10)

    --debug
    if self.lastCollision then
        local x, y = self.lastCollision.collider:getPosition()
        love.graphics.circle('fill', x, y, 3)
    end

    love.graphics.setColor(0, 0, 0)
    local statesSymbol = {
        "W",
        "F",
        "C",
        "A"
    }
    love.graphics.print(statesSymbol[self.state], cx-5, cy-5)


end

return Soldier