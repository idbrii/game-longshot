local Entity = require('entity')
local M = require("moses.moses")
local Projectile = require('projectile')
local Sensor = require('sensor')
local Vec = require('hump.vector')
local Vfx = require('vfx')
local tuning = require('tuning')

local Bomb = Entity:subclass('Bomb')

Bomb.launchCoolDown = tuning.cool_downs.bomb

function Bomb:initialize(gamestate, owner, x, y, launch_params)
    Entity.initialize(self, gamestate, owner, 'bomb')
    self.techEffect = launch_params.techEffect
    self.projectile = Projectile:new(gamestate, owner, x, y, 10, gamestate.art.bomb, launch_params.techEffect)
    self.projectile.triggerdeath_cb = function()
        self:die()
    end
    self:setCollider(self.projectile.collider)
    self.sensor = Sensor:new(gamestate, owner, x, y, 50)

    self.tint = 1
    table.insert(self.projectile.onHitWall_cb, function(...)
        self:onHitSomething(...)
    end)
    table.insert(self.projectile.onHitBuilding_cb, function(...)
        self:onHitSomething(...)
    end)
end

function Bomb:update(dt)
    self.sensor:setPosition(self.collider:getPosition())
    self.sensor:update(dt)
    self.projectile:update(dt)
end
function Bomb:draw()
    self.projectile:draw()
    self.sensor:draw()
end


function Bomb:die()
    Entity.die(self)
    self.projectile:die()
    self.sensor:die()
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

function Bomb:_explode()
    for i,ent in ipairs(self.sensor:getCollidingEntities()) do
        if ent.damagable then
            ent.damagable:takeDamage(tuning.damage_dealer.bomb)
        else
            print("Why doesn't this thing have a damagable?", ent)
        end
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
