local autotile = require("autotile.autotile")
local pl_table = require('pl.tablex')
local class = require("astray.MiddleClass")
local wf = require("windfield")

local KillVolume = class("KillVolume")

KillVolume.collision_class = 'Kill'

function KillVolume:initialize(gamestate, x,y, width,height)
    table.insert(gamestate.entities, self)
    self.collider = gamestate.world:newRectangleCollider(0,y, width,height)
    self.collider:setType('static')
    self.collider:setSensor(true)
    self.collider:setCollisionClass(KillVolume.collision_class)
end

function KillVolume:registerCollision(world)
    world:addCollisionClass(KillVolume.collision_class, {ignores = {'Block'}})
end

function KillVolume:update(gamestate, dt)
    local victim = 'Soldiers'
    if self.collider:enter(victim) then
        local collision_data = self.collider:getEnterCollisionData(victim)
        collision_data.Collder:applyLinearImpulse(1000, 0)
        collision_data.Collder:applyAngularImpulse(5000)
    end
end

function KillVolume:draw(grid)
    local x,y = self.collider:getPosition()
    --~ love.graphics.rectangle('line', x, y, 100, 100)
end

return KillVolume
