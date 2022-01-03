local Entity = require('entity')
local Projectile = require('projectile')
local Vec = require('hump.vector')
local pretty = require("pl.pretty")
local tuning = require('tuning')

local PreviewProjectile = Entity:subclass('PreviewProjectile')

PreviewProjectile.launchCoolDown = 0
PreviewProjectile.collision_class = 'Preview'

function PreviewProjectile:initialize(gamestate, owner, x, y, launch_params)
    Entity.initialize(self, gamestate, owner, launch_params.projectile_type)
    self.techEffect = launch_params.techEffect
    self.projectile = Projectile:new(self, owner, x, y, tuning.size.radius[launch_params.projectile_type], gamestate.art.balls[launch_params.projectile_type], launch_params.techEffect, false)
    self.projectile.can_cause_damage = false
    self.projectile.triggerdeath_cb = function()
        self:die()
    end
    table.insert(self.projectile.onWallActivate_cb, function(_, ...)
        self:die()
    end)
    table.insert(self.projectile.onHitBuilding_cb, function(...)
        self:die()
    end)
    self.projectile.collider:setCollisionClass(PreviewProjectile.collision_class)
    self:setCollider(self.projectile.collider)
    self.projectile.tint = 0.25
end

function PreviewProjectile:die()
    self.collider = nil -- Before Entity to prevent death explosion
    self.projectile:die()
    Entity.die(self)
end
function PreviewProjectile:update(dt, gamestate)
    Entity.update(self, dt)
    self.projectile:update(dt, gamestate)
end
function PreviewProjectile:draw()
    Entity.draw(self)
    if not self.projectile.has_stabilized then
        self.projectile:draw()
    end
end

return PreviewProjectile
