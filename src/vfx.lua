local class = require('astray.MiddleClass')

local Vfx = class('Vfx')

Vfx.effects = {
}

function Vfx.load()
    Vfx.effects.poof = love.graphics.newImage("assets/textures/poof.png")
end

function Vfx:initialize(gamestate, x, y, effect_name, params)
    table.insert(gamestate.entities, self)
    self.gamestate = gamestate
    self.x = x
    self.y = y
    self.img = Vfx.effects[effect_name]
    self.remaining_seconds = params.lifetime
    self.fade_seconds_left = params.fade_seconds
    self.total_fade_seconds = params.fade_seconds
end

function Vfx:update(dt)
    self.remaining_seconds = self.remaining_seconds - dt 
    if self.remaining_seconds < 0 then
        self.gamestate:removeEntity(self)
    end
    if self.fade_seconds_left then
        self.fade_seconds_left = self.fade_seconds_left - dt
    end
end
function Vfx:draw()
    local alpha = 1
    if self.fade_seconds_left then
        alpha = self.fade_seconds_left / self.total_fade_seconds
    end
    love.graphics.setColor(255, 255, 255, alpha)
    love.graphics.draw(self.img, self.x, self.y)
end

return Vfx
