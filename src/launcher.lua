local M = require("moses.moses")
local Projectile = require('projectile')
local Vec = require('hump.vector')
local utils = require("pl.utils")
local tablex = require("pl.tablex")
local Damagable = require("damagable")
local class = require('astray.MiddleClass')
local Entity = require('entity')

local Launcher = Entity:subclass('Launcher')

function Launcher.load()
    Launcher.sprite_body = love.graphics.newImage("assets/textures/launcher.png")
    Launcher.sprite_arm = love.graphics.newImage("assets/textures/launcher_aimer.png")
end

function Launcher:initialize(gamestate, owner, x, y)
    Entity.initialize(self, gamestate, owner)
    self.damagable = Damagable:new(1000, utils.bind1(self.die, self))
    self.owner:addLauncher(self)
    self.projectile = Projectile:new(gamestate, owner, x, y, 30)
    table.insert(self.projectile.onHitWall_cb, function(...)
        self:onHitWall(...)
    end)
    self:setCollider(self.projectile.collider)
    self.collider:applyLinearImpulse(500, 500)
    self.projectile.tint = 0.1
    self.radius = self.projectile.radius
end

function Launcher:update(dt, gamestate)
    Entity.update(self, dt)
    self.projectile:update(dt, gamestate)
end
function Launcher:draw()
    Entity.draw(self)
    self.projectile:draw()
    
    local x,y = self.collider:getPosition()
    local w,h = Launcher.sprite_body:getDimensions()
    love.graphics.draw(Launcher.sprite_body, x - w/2, y - h/2)
end

function Launcher:onHitWall(collision_data)
end

function Launcher:hasStabilized()
    return self.projectile.has_stabilized
end

function Launcher:die()
    self.player:removeLauncher(self)
    self.projectile:die()
    Entity.die(self)
end

return Launcher
