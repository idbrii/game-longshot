local M = require('moses.moses')
local class = require("astray.MiddleClass")

local KillVolume = class("KillVolume")

KillVolume.collision_class = 'Kill'


function KillVolume:initialize(gamestate, x,y, width,height, victims)
    self.width = width
    self.height = height
    table.insert(gamestate.entities, self)
    self.collider = gamestate.world:newRectangleCollider(x,y, width,height)
    --~ self.last_create_pos = {x,y, width,height}
    self.collider:setType('static')
    self.collider:setCollisionClass(KillVolume.collision_class)
    self.victims = victims
end

function KillVolume:registerCollision(world)
    world:addCollisionClass(KillVolume.collision_class, {ignores = {'Block'}})
end

function KillVolume:update(gamestate, dt)
    local ents = M.map(self.victims, function(victim,k)
        if self.collider:enter(victim) then
            local collision_data = self.collider:getEnterCollisionData(victim)
            local ent = collision_data.collider:getObject()
            return ent
        end
    end)
    ents = M.select(ents, function(v,k)
        return v ~= nil
    end)
    for i,ent in ipairs(ents) do
        -- Colliders that enter collision and are destroyed don't seem to exit
        -- collision, so we need to be careful about if they're dead.
        if ent and not ent.is_dead then
            ent:die()
        end
    end
end

function KillVolume:draw(grid)
    --~ love.graphics.rectangle('fill', unpack(self.last_create_pos))
end

return KillVolume
