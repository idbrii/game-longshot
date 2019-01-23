local autotile = require("autotile.autotile")
local pl_table = require('pl.tablex')
local class = require("astray.MiddleClass")
local wf = require("windfield")

local KillVolume = class("KillVolume")

KillVolume.collision_class = 'Kill'

local last_create_pos

function KillVolume:initialize(gamestate, x,y, width,height)
    self.width = width
    self.height = height
    table.insert(gamestate.entities, self)
    self.collider = gamestate.world:newRectangleCollider(x,y, width,height)
    last_create_pos = {x,y, width,height}
    print(unpack(last_create_pos))
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
    --~ love.graphics.rectangle('fill', unpack(last_create_pos))
end

return KillVolume
