local Damagable = require("damagable")
local Entity = require('entity')
local M = require("moses.moses")
local Projectile = require('projectile')
local Vec = require('hump.vector')
local class = require('astray.MiddleClass')
local lume = require('rxi.lume')
local tablex = require("pl.tablex")
local utils = require("pl.utils")

local Launcher = Entity:subclass('Launcher')

function Launcher.load()
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
    local w,h = self.gamestate.art.launcher:getDimensions()
    love.graphics.draw(self.gamestate.art.launcher, x - w/2, y - h/2)

    local r = 0
    if self.aim_dir then
        r = lume.angle(0, 0, self.aim_dir.x, self.aim_dir.y) + math.pi/2
    end

    w,h = self.gamestate.art.launcher_arm:getDimensions()
    love.graphics.draw(self.gamestate.art.launcher_arm, x, y,
        r,
        1, 1,
        w/2, h/2)
end

function Launcher:poseArm(aim_dir)
    self.aim_dir = aim_dir
end

function Launcher:parkArm()
    self.aim_dir = nil
end

function Launcher:onHitWall(collision_data)
end

function Launcher:hasStabilized()
    return self.projectile.has_stabilized
end

function Launcher:die()
    self.owner:removeLauncher(self)
    self.projectile:die()
    Entity.die(self)
end

return Launcher
