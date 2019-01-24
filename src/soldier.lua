local class = require("astray.MiddleClass")
local pretty = require("pl.pretty")
local tablex = require("pl.tablex")

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
    self.startingHp = 100
    self.hp = self.startingHp
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

function Soldier:takeDamage(damage)
    self.hp = self.hp - damage
    if self.hp <= 0 then
        self:die()
    end
end

function Soldier:die()
    local idx = tablex.find(self.gamestate.entities, self)
    table.remove(self.gamestate.entities, idx)
    self.collider:destroy()
end

function Soldier:attack(other)
    other:takeDamage(self.attackDamage)
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
                self:reverseDirection()
            end
        elseif self.state == states.walking or self.state == states.falling and didCollideAboveFloor then
            self:walkBounce()
        end
    end

    if self.lastCollisionTs and (ts - self.lastCollisionTs) > self.stuckTimeout then
        self:reverseDirection()
        self:walkBounce()
    end

    if self.collider:enter('SoldiersP1')
            or self.collider:enter('SoldiersP2') then
        local collision = self.collider:getEnterCollisionData('SoldiersP1') or
            self.collider:getEnterCollisionData('SoldiersP2')
        local soldier = collision.collider:getObject()
        -- no idea why we sometimes get collision data without the attached objec
        if soldier then
            self:attack(soldier)
        --else
        --    print(self.collider.collision_class .. "->" .. collision.collider.collision_class)
        end

    end

end
function Soldier:draw()
    love.graphics.setColor(255, 0, 255)
    local cx,cy = self.collider:getPosition()
    local r, g, b = self.owner:getColour()
    love.graphics.setColor(r, g, b, self.hp / self.startingHp)
    love.graphics.circle('fill', cx, cy, 10)

    --debug
    if self.lastCollision then
        local x, y = self.lastCollision.collider:getPosition()
        love.graphics.circle('fill', x, y, 3)
    end




end

return Soldier