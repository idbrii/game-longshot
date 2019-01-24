local class = require("astray.MiddleClass")

local Entity = class('Entity')

function Entity:initialize(gamestate, owner)
    self.gamestate = gamestate
    self.gamestate:addEntity(self)
    self.owner = owner
    self.onupdate_cb = {}
    self.ondraw_cb = {}
end

function Entity:die()
    self.gamestate:removeEntity(self)
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
