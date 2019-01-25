local Projectile = require('projectile')
local Soldier = require("soldier")
local utils = require("pl.utils")
local tablex = require("pl.tablex")
local Damagable = require("damagable")
local Entity = require('entity')
local CoolDown = require('cooldown')
local Barracks = Entity:subclass('Barracks')

function Barracks:initialize(gamestate, owner, x, y, launch_params)
    Entity.initialize(self, gamestate, owner)
    launch_params = launch_params or {}
    if launch_params.direction == nil then
        print('[Barracks] No direction giving. Defaulting to player direction.')
        if owner.index == 1 then
            launch_params.direction = 1
        else
            launch_params.direction = -1
        end
    end
    self.projectile = Projectile:new(gamestate, owner, x, y, 32)
    --~ table.insert(self.projectile.onHitWall_cb, function(...)
    --~     self:onHitWall(...)
    --~ end)
    self:setCollider(self.projectile.collider)
    self.radius = self.projectile.radius
    self.damagable = Damagable:new(1000, utils.bind1(self.die, self))
    self.cooldown = CoolDown:new(self.projectile.collider, -self.radius, self.radius , self.radius * 2)
    self.direction = launch_params.direction
    self.deployed = false
    self.tint = 1
end

function Barracks:spawnInterval()
    return 2
end

function Barracks:deploy()
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

    if self.collider:enter('Block') then
        self:deploy()
    end
end
function Barracks:draw()
    Entity.draw(self)
    self.projectile:draw()
    local cx,cy = self.collider:getPosition()
    local r, g, b = self.owner:getColour()
    self.damagable:drawHpBar(8, cx - self.radius, cy - 40, self.radius * 2, r, g, b)
    self.cooldown:draw()
    love.graphics.setColor(self.owner:getColour())
    love.graphics.draw(self.gamestate.art.barracks,
            cx-self.radius * self.direction, cy-self.radius, 0, self.direction, 1)
end

function Barracks:die()
    Entity.die(self)
    self.projectile:die()
end

return Barracks
