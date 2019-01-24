local M = require("moses.moses")
local Projectile = require('projectile')
local Vec = require('hump.vector')
local Vfx = require('vfx')

local Bomb = Projectile:subclass('Bomb')

Bomb.collision_class = 'Building'

function Bomb:initialize(gamestate, owner, x, y, launch_params)
    Projectile.initialize(self, gamestate, owner, x, y)
    self.collider:setCollisionClass(Bomb.collision_class)
    self.tint = 1
end

function Bomb:update()
    Projectile.update(self)
end
function Bomb:draw()
    Projectile.draw(self)
end

function Bomb:onHitWall(collision_data)
    -- ignore Projectile behavior
    self:_explode()
end

local function tryDestroyTile(grid, x, y)
    if grid[x] and grid[x][y] then
        grid[x][y] = false
    end
end

function Bomb:_explode()
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
    Vfx:new(self.gamestate, screen_pos.x, screen_pos.y, 'poof', 3)
end

return Bomb
