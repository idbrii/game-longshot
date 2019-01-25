local M = require("moses.moses")
local Vec = require('hump.vector')
local class = require("astray.MiddleClass")
local moremath = require('moremath')
local pl_table = require('pl.tablex')
local pretty = require("pl.pretty")
local tuning = require('tuning')

-- A thing that might be launched out of a Launcher.
local Sensor = class('Sensor')

Sensor.collision_class = 'Sensor'

function Sensor:initialize(gamestate, owner, x, y, radius)
    self.gamestate = gamestate
    --~ print("Sensor:", "creating at", x, y)
    self.owner = owner
    self.radius = radius or 10
    self.collider = gamestate.world:newCircleCollider(x, y, self.radius)
    self.collider:setSensor(true)
    self.collider:setCollisionClass(Sensor.collision_class)
end

function Sensor:die()
    self.collider:destroy()
    self.collider = nil
end

function Sensor:update(dt)
    --~ local wall = 'Block'
    --~ if self.collider:enter(wall) then
    --~     local collision_data = self.collider:getEnterCollisionData(wall)
    --~     self:onHitWall(collision_data)
    --~ elseif self.collider:enter(Sensor.collision_class) then
    --~     local collision_data = self.collider:getEnterCollisionData(Sensor.collision_class)
    --~     if not self.source_launcher_hit then
    --~         self.source_launcher_hit = collision_data.collider
    --~     elseif self.has_cleared_launcher or self:isMotionless() then
    --~         self.has_cleared_launcher = true
    --~         self:onHitBuilding(collision_data)
    --~     elseif self.source_launcher_hit ~= collision_data.collider then
    --~         self.has_cleared_launcher = true
    --~     end
    --~     self.has_cleared_launcher = true
    --~ else
    --~     self.has_cleared_launcher = true
    --~ end
end

function Sensor:draw()
    --~ local cx,cy = self.collider:getPosition()
    --~ love.graphics.setColor(self.owner:getColour())
    --~ local w,h = self.sprite:getDimensions()
    --~ love.graphics.circle('line',
    --~     cx,cy,
    --~     nil,
    --~     0.5, 0.5,
    --~     w/2, h/2)
end

function Sensor:setPosition(x,y)
    self.collider:setPosition(x,y)
end

function Sensor:getCollidingEntities()
    local collision_data = self.collider:getStayCollisionData(Sensor.collision_class)
    if collision_data == nil then
        return {}
    end
    pretty.dump(collision_data)
    local v = M.invoke(M.pluck(collision_data, 'collider'), 'getObject')
    return v
    --~ return M(collision_data)
    --~     :pluck('collider')
    --~     :invoke('getObject')
    --~     :value()
end

return Sensor
