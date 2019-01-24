local class = require('astray.MiddleClass')

local Vfx = class('Vfx')

Vfx.effects = {
}

function Vfx.load()
    Vfx.effects.poof = love.graphics.newImage("assets/textures/poof.png")
end

function Vfx:initialize(gamestate, x, y, effect_name, lifetime)
    table.insert(gamestate.entities, self)
    self.gamestate = gamestate
    self.x = x
    self.y = y
    self.img = Vfx.effects[effect_name]
    self.remaining_seconds = lifetime
end

function Vfx:update(dt)
    self.remaining_seconds = self.remaining_seconds - dt 
    if self.remaining_seconds < 0 then
        self.gamestate:removeEntity(self)
    end
end
function Vfx:draw()
    love.graphics.draw(self.img, self.x, self.y)
end

return Vfx
