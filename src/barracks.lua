local Projectile = require('projectile')
local Soldier = require("soldier")
local utils = require("pl.utils")
local tablex = require("pl.tablex")
local Damagable = require("damagable")
local Entity = require('entity')

local images = {
    deployed=love.graphics.newImage("assets/sprites/barracks/deployed.png"),
}


local Barracks = Entity:subclass('Barracks')

Barracks.collision_class = 'Building'

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
    self.collider = self.projectile.collider
    self.radius = self.projectile.radius
    self.damagable = Damagable:new(1000, utils.bind1(self.die, self))
    self.direction = launch_params.direction
    self.collider:setCollisionClass(Barracks.collision_class)
    self.collider:setObject(self)
    self.deployed = false
    self.lastSpawnAt = love.timer.getTime()
    self.tint = 1
end

function Barracks:spawnInterval()
    return 2
end

function Barracks:deploy()
    self.deployed = true
end

function Barracks:spawnSoldier()
    local cx,cy = self.collider:getPosition()
    Soldier:new(self.gamestate, self.owner, cx - self.radius * self.direction * -1.5, cy, self.direction)
end
function Barracks:update(dt)
    Entity.update(self, dt)
    self.projectile:update(dt)
    local ts = love.timer.getTime()
    if self.collider:enter('Block') then
        self:deploy()
    end
    if self.deployed and ts > (self.lastSpawnAt + self:spawnInterval()) then
        self:spawnSoldier()
        self.lastSpawnAt = ts
    end

end
function Barracks:draw()
    Entity.draw(self)
    self.projectile:draw()
    local cx,cy = self.collider:getPosition()
    local r, g, b = self.owner:getColour()
    self.damagable:drawHpBar(8, cx - self.radius, cy - 40, self.radius * 2, r, g, b)
    if self.owner.index == 1 then
        love.graphics.setColor(0, 255, 0)
    else
        love.graphics.setColor(255, 0, 0)
    end
    love.graphics.draw(images.deployed,
            cx-self.radius * self.direction, cy-self.radius, 0, self.direction, 1)
end

function Barracks:die()
    Entity.die(self)
    self.projectile:die()
end

return Barracks
