local M = require("moses.moses")
local Projectile = require('projectile')
local Vec = require('hump.vector')

local Bomb = Projectile:subclass('Bomb')

Bomb.collision_class = 'Building'

function Bomb:initialize(gamestate, owner, x, y)
    Projectile.initialize(self, gamestate, owner, x, y)
    self.collider:setCollisionClass(Bomb.collision_class)
    self.tint = 1
end

function Bomb:update()
    Projectile.update(self)
end
function Bomb:draw()
    Projectile.draw(self)
end

function Bomb:onHitWall(collision_data)
    Projectile.onHitWall(self, collision_data)
end

return Bomb
