local Projectile = require('projectile')
local Soldier = require("soldier")
local utils = require("pl.utils")
local tablex = require("pl.tablex")
local Damagable = require("damagable")
local tuning = require('tuning')
local Entity = require('entity')
local CoolDown = require('cooldown')
local tuning = require('tuning')
local Barracks = Entity:subclass('Barracks')

Barracks.launchCoolDown = tuning.cool_downs.barracks

function Barracks:initialize(gamestate, owner, x, y, launch_params)
    Entity.initialize(self, gamestate, owner, 'barracks')
    if launch_params.direction == nil then
        print('[Barracks] No direction giving. Defaulting to player direction.')
        if owner.index == 1 then
            launch_params.direction = 1
        else
            launch_params.direction = -1
        end
    end
    self.techEffect = launch_params.techEffect
    self.projectile = Projectile:new(self, owner, x, y, 32, gamestate.art.balls.barracks, launch_params.techEffect, true)
    self.projectile.triggerdeath_cb = function()
        self:die()
    end
    table.insert(self.projectile.onWallActivate_cb, function(_, ...)
        self:deploy(...)
    end)
    table.insert(self.projectile.onHitBuilding_cb, function(...)
        self:die()
    end)
    self:setCollider(self.projectile.collider)
    self.radius = self.projectile.radius
    self.damagable = Damagable:new(tuning.health.barracks, utils.bind1(self.die, self))
    self.cooldown = CoolDown:new(self.projectile.collider, -self.radius, self.radius , self.radius * 2)
    self.direction = launch_params.direction
    self.deployed = false
    self.tint = 1
    self.attachmentAngle = 0
end

function Barracks:spawnInterval()
    return 2
end

function Barracks:deploy(collision_data, angle)
    self.attachmentAngle = angle
    self.deployed = true
    self.cooldown:set(self:spawnInterval(), function()
        self:spawnSoldier()
    end)
end

function Barracks:spawnSoldier()
    local cx,cy = self.collider:getPosition()
    Soldier:new(self.gamestate, self.owner, cx - self.radius * self.direction * -1.5, cy, self.direction)
    self.cooldown:set(self:spawnInterval(), function()
        self:spawnSoldier()
    end)
end
function Barracks:update(dt)
    Entity.update(self, dt)
    self.projectile:update(dt)
    self.cooldown:update(dt)
end
function Barracks:draw()
    Entity.draw(self)
    if not self.projectile.has_stabilized then
        self.projectile:draw()
    else
        love.graphics.setColor(self.owner:getColour())
        local cx,cy = self.collider:getPosition()
        local r, g, b = self.owner:getColour()
        self.damagable:drawHpBar(8, cx - self.radius, cy - 40, self.radius * 2, r, g, b)
        self.cooldown:draw()
        love.graphics.setColor(self.owner:getColour())
        local isVertical = (round(self.attachmentAngle) - self.attachmentAngle) == 0
        love.graphics.draw(self.gamestate.art.barracks,
            cx, cy, self.attachmentAngle,
                isVertical and self.direction or  1,
                isVertical and 1 or self.direction,
            self.radius, self.radius)
    end
end

function Barracks:die()
    Entity.die(self)
    self.projectile:die()
end

return Barracks
