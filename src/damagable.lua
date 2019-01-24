local class = require("astray.MiddleClass")

local Damagable = class("Damagable")

function Damagable:initialize(startingHealth, onDeath)
    self.startingHealth = startingHealth
    self.hp = self.startingHealth
    self.onDeath = onDeath
end

function Damagable:takeDamage(damage)
    self.hp = self.hp - damage
    if self.hp <= 0 then
        self.onDeath()
    end
end

function Damagable:drawHpBar(thickness, x, y, width, r, g, b)
    love.graphics.setColor(r, g, b)
    local hp = self:percentHp()
    if hp < 1 then
        love.graphics.setLineWidth(thickness)
        love.graphics.line(x, y, x + width, y )
    end
end

function Damagable:percentHp()
    return self.hp / self.startingHealth
end

return Damagable