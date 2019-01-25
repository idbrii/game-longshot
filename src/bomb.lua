local Entity = require('entity')
local Damagable = require "damagable"
local M = require("moses.moses")
local Projectile = require('projectile')
local Vec = require('hump.vector')
local Vfx = require('vfx')
local tuning = require('tuning')

local Bomb = Entity:subclass('Bomb')

Bomb.launchCoolDown = tuning.cool_downs.bomb

function Bomb:initialize(gamestate, owner, x, y, launch_params)
    Entity.initialize(self, gamestate, owner, 'bomb')
    self.techEffect = launch_params.techEffect
    self.projectile = Projectile:new(self, owner, x, y, 10, gamestate.art.bomb, launch_params.techEffect, false)
    self.projectile.triggerdeath_cb = function()
        self:die()
    end
    self:setCollider(self.projectile.collider)

    self.tint = 1
    table.insert(self.projectile.onWallActivate_cb, function(...)
        self:onHitSomething(...)
    end)
    table.insert(self.projectile.onHitBuilding_cb, function(...)
        self:onHitSomething(...)
    end)
end

function Bomb:update(dt)
    self.projectile:update(dt)
end
function Bomb:draw()
    self.projectile:draw()
end


function Bomb:die()
    Entity.die(self)
    self.projectile:die()
end

function Bomb:onHitSomething(collision_data)
    -- ignore Projectile behavior
    self:_explode()
end

local function tryDestroyTile(grid, x, y)
    if grid[x] and grid[x][y] then
        grid[x][y] = false
    end
end

function Bomb:_getBlastRadiusEntities()
    -- queryCircleArea and sensors don't work. Just brute force it.
    local pos = Vec(self.collider:getPosition())
    local rad2 = tuning.size.bomb.blast_radius * tuning.size.bomb.blast_radius
    local victims = {}
    for i,ent in ipairs(self.gamestate.entities) do
        if ent.collider and ent.damagable and ent ~= self then
            local victim_pos = Vec(ent.collider:getPosition())
            if pos:dist2(victim_pos) < rad2 then
                table.insert(victims, ent)
            end
        end
    end
    return victims
end

function Bomb:_explode()
    for i,ent in ipairs(self:_getBlastRadiusEntities()) do
        ent.damagable:takeDamage(tuning.damage_dealer.bomb)
    end
    local screen_pos = Vec(self.collider:getPosition())
    local grid_pos = self.gamestate.map:toGridPosVector(screen_pos)
    local grid = self.gamestate.grid
    tryDestroyTile(grid, grid_pos.x, grid_pos.y)
    tryDestroyTile(grid, grid_pos.x-1, grid_pos.y)
    tryDestroyTile(grid, grid_pos.x+1, grid_pos.y)
    tryDestroyTile(grid, grid_pos.x, grid_pos.y-1)
    tryDestroyTile(grid, grid_pos.x, grid_pos.y+1)
    self.gamestate.map:refresh(grid)
    self:die()
    Vfx:new(self.gamestate, screen_pos.x, screen_pos.y, 'poof', {
            lifetime = 2,
            fade_seconds = 2,
        })
end

return Bomb
