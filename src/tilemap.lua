local autotile = require("autotile.autotile")
local class = require("astray.MiddleClass")

local TileMap = class("TileMap")

function TileMap:initialize(floor_image, autotile_image, tile_size, world_width, world_height)
	self.floor_image = floor_image
	self.tiler = autotile(autotile_image, tile_size)
    self.world_width = world_width
    self.world_height = world_height
    self.tile_size = tile_size
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
