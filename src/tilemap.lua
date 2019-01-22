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

function TileMap:registerCollision(world, player_class)
    world:addCollisionClass('Block')
    world:addCollisionClass('Ghost', {ignores = { player_class, 'Block' }})

    local size = self.tile_size
	for x = 0, self.world_width do
        if self.colliders[x] == nil then
            self.colliders[x] = {}
        end
		for y = 0, self.world_height do
			local c = world:newRectangleCollider(x*size, y*size, size, size)
            c:setType('static')
            c:setCollisionClass('Block')
            self.colliders[x][y] = c
        end
    end
end

function TileMap:refresh(grid)
    local size = self.tile_size
	for x = 0, self.world_width do
		for y = 0, self.world_height do
            local col_class = 'Ghost'
            local has_collision = grid[x][y]
            if has_collision then
                col_class = 'Block'
            end
            self.colliders[x][y]:setCollisionClass(col_class)
        end
    end
end

function TileMap:draw(grid)
	-- Draw the autotiles
    local size = self.tile_size
	for x = 0, self.world_width do
		for y = 0, self.world_height do
			if grid[x] and grid[x][y] then
				self.tiler:drawAutotile(grid,x,y)
			else
				love.graphics.draw(self.floor_image, x*size, y*size)
			end
		end
	end
end

function TileMap:box2d_draw(tx,ty)
end

return TileMap
