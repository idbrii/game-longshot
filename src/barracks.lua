local Projectile = require('projectile')
local Soldier = require("soldier")

local Barracks = Projectile:subclass('Barracks')

Barracks.collision_class = 'Building'

function Barracks:initialize(gamestate, owner, x, y, direction)
    Projectile.initialize(self, gamestate, owner, x, y, 32)
    self.direction = direction
    self.collider:setCollisionClass(Barracks.collision_class)
    self.deployed = false
    self.lastSpawnAt = love.timer.getTime()
end

function Barracks:spawnInterval()
    return 2
end

function Barracks:deploy()
    self.deployed = true
end

function Barracks:spawnSoldier()
    local cx,cy = self.collider:getPosition()
    Soldier:new(self.gamestate, self.owner, cx - self.radius / -2 * self.direction, cy, self.direction)
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
    love.graphics.setColor(self.owner:getColour())
    love.graphics.circle('line', cx, cy, self.radius)
end



return Barracks
