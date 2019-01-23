local autotile = require("autotile.autotile")
local class = require("astray.MiddleClass")
local wf = require("windfield")

local TileMap = class("TileMap")

function TileMap:initialize(floor_image, autotile_image, tile_size, world_width, world_height)
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

function TileMap:registerCollision(world, player_class)
    world:addCollisionClass('Block')
    world:addCollisionClass('Ghost', {ignores = { player_class, 'Block' }})

    local size = self.tile_size
    self:_foreachTile(function(x,y)
        local c = world:newRectangleCollider(x*size, y*size, size, size)
        c:setType('static')
        c:setCollisionClass('Block')
        self.colliders[x][y] = c
    end)
end

function TileMap:refresh(grid)
    self:_foreachTile(function(x,y)
        local col_class = 'Ghost'
        local has_collision = grid[x][y]
        if has_collision then
            col_class = 'Block'
        end
        self.colliders[x][y]:setCollisionClass(col_class)
    end)
end

function TileMap:draw(grid)
    -- Draw the autotiles
    local size = self.tile_size
    self:_foreachTile(function(x,y)
        if grid[x] and grid[x][y] then
            self.tiler:drawAutotile(grid,x,y)
        else
            love.graphics.draw(self.floor_image, x*size, y*size)
        end
    end)
end

function TileMap:_findEmptyCollision(grid, start_x, start_y, get_x_fn)
    for x_iterator = start_x, self.world_width do
        local x = get_x_fn(x_iterator)
        for y = start_y, self.world_height do
            if not grid[x][y] then
                return x,y
            end
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

function TileMap:buildStartPoints(grid)
    local start_radius = 2
    local start_indent = start_radius+1
    local p1_grid = {}
    p1_grid.x, p1_grid.y = self:_findEmptyCollision(grid, start_indent, start_indent, function(x_iterator)
        return x_iterator
    end)
    local p2_grid = {}
    p2_grid.x,p2_grid.y = self:_findEmptyCollision(grid, start_indent, start_indent, function(x_iterator)
        return self.world_width - x_iterator
    end)
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
