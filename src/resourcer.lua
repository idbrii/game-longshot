local Projectile = require('projectile')
local Vec = require('hump.vector')
local pretty = require("pl.pretty")
local utils = require("pl.utils")
local tablex = require("pl.tablex")
local Damagable = require("damagable")
local Entity = require('entity')


local Resourcer = Entity:subclass('Resourcer')
Resourcer.collision_class = 'Building'
local MAX_RESOURCER_TICK = 30
local MAX_TICK_IN_GENERATIONS = 60
function Resourcer:initialize(gamestate, owner, x, y, launch_params)
    Entity.initialize(self, gamestate, owner)
    self.projectile = Projectile:new(gamestate, owner, x, y, 32)
    --~ table.insert(self.projectile.onHitWall_cb, function(...)
    --~     self:onHitWall(...)
    --~ end)
    self.collider = self.projectile.collider
    self.radius = self.projectile.radius
    self.damagable = Damagable:new(1000, utils.bind1(self.die, self))
    self.collider:setCollisionClass(Resourcer.collision_class)
    self.collider:setObject(self)
    self.lastExpansion = love.timer.getTime()
    self.generation = 1
end
function Resourcer:expandInterval()
    return MAX_RESOURCER_TICK * (math.min(self.generation, MAX_TICK_IN_GENERATIONS) / MAX_TICK_IN_GENERATIONS)
end

function Resourcer:deploy()
    local contacts = self.collider:getContacts('Block')
    for i, contact in ipairs(contacts) do
        local x, y = contact:getPositions()
        if x ~= nil then
            local tilePos = self.gamestate.map:toGridPosVector(Vec(x,y))
            self.gamestate.claims:claimFromResourcer(self, tilePos.x, tilePos.y)
        end
    end
end
function Resourcer:update(dt)
    Entity.update(self, dt)
    self.projectile:update(dt)
    if self.collider:enter('Block') then
        self:deploy()
    end

end
function Resourcer:draw()
    Entity.draw(self)
    self.projectile:draw()
    local cx,cy = self.collider:getPosition()
    local r, g, b = self.owner:getColour()
    love.graphics.setColor(r, g, b, self.damagable:percentHp())
    love.graphics.circle('fill', cx, cy, self.radius)
end
function Resourcer:die()
    Entity.die(self)
    self.projectile:die()
end

return Resourcer
