local M = require("moses.moses")
local Projectile = require('projectile')
local Vec = require('hump.vector')

local Barracks = Projectile:subclass('Barracks')

Barracks.collision_class = 'Building'

function Barracks:initialize(gamestate, owner, x, y)
    Projectile.initialize(self, gamestate, owner, x, y)
    self.collider:setCollisionClass(Barracks.collision_class)
end

function Barracks:update()
    Projectile.update(self)
end
function Barracks:draw()
    Projectile.draw(self)
end

function Barracks:onHitWall(collision_data)
    Projectile.onHitWall(self, collision_data)
end

return Barracks
