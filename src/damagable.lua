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

function Damagable:percentHp()
    return self.hp / self.startingHealth
end

return Damagable