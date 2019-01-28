local Damagable = require "damagable"
local KillVolume = require('killvolume')
local Vec = require('hump.vector')
local autotile = require("autotile.autotile")
local class = require("astray.MiddleClass")
local pl_table = require('pl.tablex')
local wf = require("windfield")

local TileMap = class("TileMap")

function TileMap:initialize(gamestate, floor_image, autotile_image, tile_size, world_width, world_height)
    self.gamestate = gamestate
    self.floor_image = floor_image
    self.tiler = autotile(autotile_image, tile_size)
    self.world_width = world_width
    self.world_height = world_height
    self.tile_size = tile_size
    self.colliders = {}
end

function TileMap:_foreachTile(fn)
    for x = 0, self.world_width do
        if self.colliders[x] == nil then
            self.colliders[x] = {}
        end
        for y = 0, self.world_height do
            fn(x,y)
        end
    end
end

function TileMap:fixupGrid(grid)
    for x = 0, self.world_width do
        grid[x][1] = true
        grid[x][2] = true
        grid[x][self.world_height-1] = true
        grid[x][self.world_height] = true
    end
    for y = 0, self.world_height do
        grid[1][y] = true
        grid[2][y] = true
        grid[self.world_width-1][y] = true
        grid[self.world_width][y] = true
    end
end

function TileMap:registerCollision(world, mob_collision_classes)
    world:addCollisionClass('Block')
    local ignore_classes = pl_table.copy(mob_collision_classes)
    table.insert(ignore_classes, 'Block')
    world:addCollisionClass('Ghost', {ignores = ignore_classes})
    world:addCollisionClass(KillVolume.collision_class, {ignores={'Block', 'Ghost'}})

    local size = self.tile_size
    self:_foreachTile(function(x,y)
        local c = world:newRectangleCollider(x*size, y*size, size, size)
        c:setType('static')
        c:setCollisionClass('Block')
        self.colliders[x][y] = c
    end)

    local bottom = (self.gamestate.config.world_height + 1) * size
    -- Seems like physics is clamped to screen size.
    local victims = pl_table.copy(Damagable.collision_classes)
    table.insert(victims, 'SoldiersP1')
    table.insert(victims, 'SoldiersP2')
    self.kill_floor = KillVolume:new(self.gamestate, 0, bottom, (self.gamestate.config.world_width + 1) * size, size, victims)
end

function TileMap:refresh(grid)
    self.gamestate.claims:refresh(self, grid)
    self:_foreachTile(function(x,y)
        local col_class = 'Ghost'
        local has_collision = grid[x][y]
        if has_collision then
            col_class = 'Block'
        end
        self.colliders[x][y]:setCollisionClass(col_class)
    end)
end

function TileMap:update(gamestate, dt)
    self.kill_floor:update(gamestate, dt)
end

function TileMap:draw(grid)
    love.graphics.setColor(1,1,1)
    -- Draw the autotiles
    local size = self.tile_size
    self:_foreachTile(function(x,y)
        if grid[x] and grid[x][y] then
            self.tiler:drawAutotile(grid,x,y)
        else
            love.graphics.draw(self.floor_image, x*size, y*size)
        end
    end)
    self.kill_floor:draw()
end

function TileMap:_findEmptyCollision(grid, start_x, start_y, get_x_fn)
    local found
    for x_iterator = start_x, self.world_width do
        local x = get_x_fn(x_iterator)
        for y = start_y, self.world_height do
            if not grid[x][y] then
                -- good, but see if there's a lower starting point?
                found = {x,y}
            end
        end

        if found then
            return unpack(found)
        end
    end
end

function TileMap:toScreenPosSingle(x)
    return x * self.tile_size + self.tile_size/2
end

function TileMap:toScreenPosVector(vector)
    return {
        x = self:toScreenPosSingle(vector.x),
        y = self:toScreenPosSingle(vector.y)
    }
end

function TileMap:toGridPosSingle(x)
    return math.floor(x / self.tile_size)
end

function TileMap:toGridPosVector(vector)
    return {
        x = self:toGridPosSingle(vector.x),
        y = self:toGridPosSingle(vector.y)
    }
end

local function makeSpace(grid, x, y, radius)
    -- Clear space
    for it_x=x-radius,x+radius do
        for it_y=y-radius,y do
            grid[it_x][it_y] = false
        end
    end

    -- but ensure well-supported.
    local down_one = y + 1
    grid[x - 1][down_one] = true
    grid[x][down_one] = true
    grid[x + 1][down_one] = true
end

function TileMap:buildStartPoints(grid)
    local start_radius = 5
    local start_indent = start_radius+1
    local p1_grid = {}
    p1_grid.x, p1_grid.y = self:_findEmptyCollision(grid, start_indent, start_indent, function(x_iterator)
        return x_iterator
    end)
    makeSpace(grid, p1_grid.x, p1_grid.y, start_radius)

    local p2_grid = {}
    p2_grid.x,p2_grid.y = self:_findEmptyCollision(grid, start_indent, start_indent, function(x_iterator)
        return self.world_width - x_iterator
    end)
    makeSpace(grid, p2_grid.x, p2_grid.y, start_radius)

    self:fixupGrid(grid)

    local p1_screen,p2_screen = self:toScreenPosVector(p1_grid), self:toScreenPosVector(p2_grid)
    return p1_screen,p2_screen
    --~ function()
    --~     love.graphics.setColor(255, 0, 0)
    --~     love.graphics.circle('fill', p1_screen.x, p1_screen.y, self.tile_size/2)
    --~     love.graphics.circle('fill', p2_screen.x, p2_screen.y, self.tile_size/2)
    --~ end
end

function TileMap:box2d_draw(tx,ty)
end

return TileMap
