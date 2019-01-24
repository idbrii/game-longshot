local M = require("moses.moses")
local Projectile = require('projectile')
local Vec = require('hump.vector')
local utils = require("pl.utils")
local tablex = require("pl.tablex")
local Damagable = require("damagable")
local class = require('astray.MiddleClass')

local Launcher = class('Launcher')

Launcher.collision_class = 'Building'

function Launcher:initialize(gamestate, owner, x, y)

    self.damagable = Damagable:new(1000, utils.bind1(self.die, self))
    self.owner = owner
    self.owner:addLauncher(self)
    self.projectile = Projectile:new(gamestate, owner, x, y)
    self.projectile.onHitWall_cb = function(collision_data)
        self:onHitWall(collision_data)
    end
    self.collider = self.projectile.collider
    self.collider:setObject(self)
    self.collider:setCollisionClass(Launcher.collision_class)
    self.collider:applyLinearImpulse(500, 500)
    self.projectile.tint = 0.1
    self.radius = self.projectile.radius
end

function Launcher:update(dt, gamestate)
    self.projectile.update(dt, gamestate)
end
function Launcher:draw()
    self.projectile.draw()
end

function Launcher:onHitWall(collision_data)
end

function Launcher:hasStabilized()
    return self.projectile.has_stabilized
end

function Launcher:die()
    local idx = tablex.find(self.gamestate.entities, self)
    table.remove(self.gamestate.entities, idx)
    self.collider:destroy()
end

return Launcher
