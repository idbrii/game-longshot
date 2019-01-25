local Vfx = require('vfx')
local class = require("astray.MiddleClass")

local Entity = class('Entity')

function Entity:initialize(gamestate, owner, type_name)
    self.gamestate = gamestate
    self.gamestate:addEntity(self)
    self.owner = owner
    self.type_name = type_name
    self.onupdate_cb = {}
    self.ondraw_cb = {}
end

function Entity:setCollider(collider)
    self.collider = collider
    self.collider:setObject(self)
end

local do_big_poof_for = {
    resourcer = true,
    barracks = true,
    launcher = true,
}

local do_person_death_for = {
    soldier = true,
}

function Entity:die()
    if self.collider then
        local poof = nil
        if do_big_poof_for[self.type_name] then
            poof = 'poof'
        elseif do_person_death_for[self.type_name] then
            poof = 'person_death'
        end

        if poof then
            local x,y = self.collider:getPosition()
            Vfx:new(self.gamestate, x, y, poof, {
                    fade_seconds = 1,
                })
        end
    end

    self.gamestate:removeEntity(self)
    for i,listener in ipairs(self.gamestate.onDie_cb) do
        listener(self)
    end
end

function Entity:update(...)
    for i,listener in ipairs(self.onupdate_cb) do
        listener(self, ...)
    end
end

function Entity:draw(...)
    for i,listener in ipairs(self.ondraw_cb) do
        listener(self, ...)
    end
end

return Entity
