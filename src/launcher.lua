local Projectile = require('projectile')

local Launcher = Projectile:subclass('Launcher')

Launcher.collision_class = 'Building'

function Launcher:initialize(gamestate, owner, x, y)
    Projectile.initialize(self, gamestate, owner, x, y)
    self.collider:setCollisionClass(Launcher.collision_class)
    self.collider:applyLinearImpulse(500, 500)
    self.owner:addLauncher(self)
end

function Launcher:update()
    Projectile.update(self)
end
function Launcher:draw()
    Projectile.draw(self)
end

return Launcher
