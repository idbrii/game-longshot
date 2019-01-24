local Projectile = require('projectile')
local Vec = require('hump.vector')
local pretty = require("pl.pretty")
local utils = require("pl.utils")
local tablex = require("pl.tablex")
local Damagable = require("damagable")
local Entity = require('entity')

local images = {
    deployed=love.graphics.newImage("assets/sprites/resourcer/deployed.png"),
}

local Resourcer = Entity:subclass('Resourcer')
local MAX_RESOURCER_TICK = 30
local MAX_TICK_IN_GENERATIONS = 60
function Resourcer:initialize(gamestate, owner, x, y, launch_params)
    Entity.initialize(self, gamestate, owner)
    self.projectile = Projectile:new(gamestate, owner, x, y, 32)
    table.insert(self.projectile.onHitWall_cb, function(...)
        self:deploy(...)
    end)
    self:setCollider(self.projectile.collider)
    self.radius = self.projectile.radius
    self.damagable = Damagable:new(1000, utils.bind1(self.die, self))
    self.lastExpansion = love.timer.getTime()
    self.generation = 1
end
function Resourcer:expandInterval()
    return MAX_RESOURCER_TICK * (math.min(self.generation, MAX_TICK_IN_GENERATIONS) / MAX_TICK_IN_GENERATIONS)
end

function Resourcer:deploy(projectile, collision_data)
    local x, y = collision_data.collider:getPosition()
    local tilePos = self.gamestate.map:toGridPosVector(Vec(x,y))
    pretty.dump({"dbriscoe:", x, y, tilePos})
    self.gamestate.claims:claimFromResourcer(self, tilePos.x, tilePos.y)
end
function Resourcer:update(dt)
    Entity.update(self, dt)
    self.projectile:update(dt)
end
function Resourcer:draw()
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
    love.graphics.draw(images.deployed, cx-self.radius, cy-self.radius)
end
function Resourcer:die()
    Entity.die(self)
    self.projectile:die()
end

return Resourcer
