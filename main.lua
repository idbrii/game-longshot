-- Not sure best way to organize code. For now, main in project root, all code
-- in src, libraries in src/lib/
love.filesystem.setRequirePath("src/?.lua;src/?/init.lua;src/lib/?.lua;src/lib/?/init.lua")
-- Monkey patch graphics to auto batch sprites.
-- TODO(dbriscoe): Maybe using out-of-date love api, but autobatch fails on
-- setBufferSize.
--~ require("rxi.autobatch")

io.stdout:setvbuf("no")
local TileMap = require("tilemap")
local gridgen = require("gridgen")

local world_width, world_height = 50, 30
local tile_size = 32

local world
local tx, ty
local points

local grid
local map

function love.load()
    grid = gridgen.generate_grid(world_width, world_height)
	map = TileMap:new(
		love.graphics.newImage("assets/textures/Floor.png"),	-- Pure grass tile
		love.graphics.newImage("assets/textures/Autotile.png"), -- Autotile image
		tile_size,
		world_width,
		world_height
		)

	-- Print versions
	print("ESCAPE TO QUIT")
	print("SPACE TO RESET TRANSLATION")

	-- Prepare translations
	tx, ty = 0, 0

	-- Prepare physics world
	love.physics.setMeter(32)
	world = love.physics.newWorld(0, 0)
	--~ map:box2d_init(world)

	-- Drop points on clicked areas
	points = {
		mouse = {},
		pixel = {}
	}
	love.graphics.setPointSize(5)
	love.window.setMode((world_width+1) * tile_size, (world_height+1) * tile_size)
end

function love.keypressed(key)
	-- Exit
	if key == "escape" or key == "q" then
		love.event.quit()
	end

	-- Reset translation
	if key == "space" then
		tx, ty = 0, 0
	end
end

function love.update(dt)
	-- hot reload code
	--~ require("rxi.lurker").update()

	world:update(dt)
	--~ map:update(dt)

	-- Move map
	local kd = love.keyboard.isDown
	local l  = kd("left")  or kd("a")
	local r  = kd("right") or kd("d")
	local u  = kd("up")    or kd("w")
	local d  = kd("down")  or kd("s")

	tx = l and tx - 128 * dt or tx
	tx = r and tx + 128 * dt or tx
	ty = u and ty - 128 * dt or ty
	ty = d and ty + 128 * dt or ty
end

function love.draw()
	-- Draw map
	love.graphics.setColor(255, 255, 255)
	map:draw(grid)

	-- Draw physics objects
	love.graphics.setColor(255, 0, 255)
	map:box2d_draw(-tx, -ty)

	-- Draw points
	--~ love.graphics.translate(-tx, -ty)

	love.graphics.setColor(255, 0, 255)
	for _, point in ipairs(points.mouse) do
		love.graphics.points(point.x, point.y)
	end

	love.graphics.setColor(255, 255, 0)
	for _, point in ipairs(points.pixel) do
		love.graphics.points(point.x, point.y)
	end
end

function love.mousepressed(x, y, button)
	if false and button == 1 then
		x = x + tx
		y = y + ty

		local tilex, tiley   = map:convertPixelToTile(x, y)
		local pixelx, pixely = map:convertTileToPixel(tilex, tiley)

		table.insert(points.pixel, { x=pixelx, y=pixely })
		table.insert(points.mouse, { x=x, y=y })

		print(x, tilex, pixelx)
		print(y, tiley, pixely)
	end
end

function love.resize(w, h)
	--~ map:resize(w, h)
end
