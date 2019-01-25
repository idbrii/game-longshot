local CoolDown = require('cooldown')
local Damagable = require("damagable")
local Entity = require('entity')
local M = require("moses.moses")
local Projectile = require('projectile')
local Vec = require('hump.vector')
local class = require('astray.MiddleClass')
local lume = require('rxi.lume')
local tablex = require("pl.tablex")
local tuning = require('tuning')
local utils = require("pl.utils")

local Launcher = Entity:subclass('Launcher')
Launcher.launchCoolDown = 10
function Launcher.load()
end

function Launcher:initialize(gamestate, owner, x, y)
    Entity.initialize(self, gamestate, owner, 'launcher')
    self.damagable = Damagable:new(tuning.health.launcher, utils.bind1(self.die, self))
    self.owner:addLauncher(self)
    self.projectile = Projectile:new(gamestate, owner, x, y, 30, gamestate.art.balls.launcher)
    self.projectile.triggerdeath_cb = function()
        self:die()
    end
    table.insert(self.projectile.onHitWall_cb, function(...)
        self:onHitWall(...)
    end)
    table.insert(self.projectile.onHitBuilding_cb, function(...)
        self:die()
    end)
    self:setCollider(self.projectile.collider)
    self.radius = self.projectile.radius
    self.cooldown = CoolDown:new(self.projectile.collider, -self.radius, self.radius+5, self.radius * 2)
    self.can_fire = true
end

function Launcher:update(dt, gamestate)
    Entity.update(self, dt)
    self.projectile:update(dt, gamestate)
    self.cooldown:update(dt)
end
function Launcher:draw()
    Entity.draw(self)
    if not self.projectile.has_stabilized then
        self.projectile:draw()
    else
        love.graphics.setColor(self.owner:getColour())
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

        self.damagable:drawHpBar(8, x - self.radius, y - 40, self.radius * 2, self.owner:getColour())
        self.cooldown:draw()
    end
end

function Launcher:poseArm(aim_dir)
    self.aim_dir = aim_dir
end

function Launcher:parkArm()
    self.aim_dir = nil
end

function Launcher:fire(projectileClass)
    self.can_fire = false
    self.cooldown:set(projectileClass.launchCoolDown, function()
        self.can_fire = true
    end)
end

function Launcher:onHitWall(collision_data)
end

function Launcher:hasStabilized()
    return self.projectile.has_stabilized
end

function Launcher:die()
    Entity.die(self)
    self.owner:removeLauncher(self)
    self.projectile:die()
end

return Launcher
