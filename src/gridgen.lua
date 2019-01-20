local astray = require("astray")

local GridGen = {}

local function _drawdungeon(tiles, startx, starty, width, height)
	print("Map size=", #tiles - startx, #tiles[1] - starty )

    for y = starty, height do
        local line = ''
		for x = startx, width do
			local tile
			if tiles[x][y] == true then
				tile = '#'
			elseif tiles[x][y] == false then
				tile = ' '
			else
				tile = '?'
			end
			line = line .. tile
		end
		print(line)
	end
	print('')
end


function GridGen.generate_grid(world_width, world_height)
    -- TODO(dbriscoe): It seems to generate worlds twice as big as asked, so
    -- divide by two.
	local generator = astray.Astray:new( world_width/2, world_height/2, 30, 70, 50, astray.RoomGenerator:new(4, 2, 4, 2, 4) )
	local dungeon = generator:Generate()
	local symbols = { Wall=true, Empty=false, DoorN=false, DoorS=false, DoorE=false, DoorW=false }
	local tiles_0_index = generator:CellToTiles(dungeon, symbols)
	--~ _drawdungeon(tiles_0_index, 0, 0, world_width, world_height)
	return tiles_0_index
end


return GridGen
