local M = require("moses.moses")
local Projectile = require('projectile')
local Vec = require('hump.vector')

local Launcher = Projectile:subclass('Launcher')

Launcher.collision_class = 'Building'

function Launcher:initialize(gamestate, owner, x, y)
    Projectile.initialize(self, gamestate, owner, x, y)
    self.collider:setCollisionClass(Launcher.collision_class)
    self.collider:applyLinearImpulse(500, 500)
    self.owner:addLauncher(self)
    self.tint = 0.1
end

function Launcher:update()
    Projectile.update(self)
end
function Launcher:draw()
    Projectile.draw(self)
end

function Launcher:onHitWall(collision_data)
    Projectile.onHitWall(self, collision_data)
end

return Launcher
