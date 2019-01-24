local Projectile = require('projectile')
local Soldier = require("soldier")
local utils = require("pl.utils")
local tablex = require("pl.tablex")
local Damagable = require("damagable")

local images = {
    deployed=love.graphics.newImage("assets/sprites/barracks/deployed.png"),
}


local Barracks = Projectile:subclass('Barracks')

Barracks.collision_class = 'Building'

function Barracks:initialize(gamestate, owner, x, y, launch_params)
    launch_params = launch_params or {}
    if launch_params.direction == nil then
        print('[Barracks] No direction giving. Defaulting to player direction.')
        if owner.index == 1 then
            launch_params.direction = 1
        else
            launch_params.direction = -1
        end
    end
    Projectile.initialize(self, gamestate, owner, x, y, 32)
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
function Barracks:update()
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
    local cx,cy = self.collider:getPosition()
    local r, g, b = self.owner:getColour()
    love.graphics.setColor(r, g, b)

    local hp = self.damagable:percentHp()
    if hp < 1 then
        love.graphics.setLineWidth(8)
        love.graphics.line(cx - (self.radius), cy - 32, cx + (self.radius * hp), cy - 32 )
    end
    if self.owner.index == 1 then
        love.graphics.setColor(0, 255, 0)
    else
        love.graphics.setColor(255, 0, 0)
    end
    love.graphics.draw(images.deployed,
            cx-36 * self.direction, cy-36, 0, self.direction, 1)
end

function Barracks:die()
    local idx = tablex.find(self.gamestate.entities, self)
    table.remove(self.gamestate.entities, idx)
    self.collider:destroy()
end

return Barracks
