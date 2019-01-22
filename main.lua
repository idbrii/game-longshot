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
local wf = require("windfield")
local Input = require('boipushy.Input')

local world_width, world_height = 50, 30
local tile_size = 32

local world
local tx, ty
local points

local input
local grid
local map

function love.load()
    input = Input()
    input:bind('q', love.event.quit)
    input:bind('escape', love.event.quit)

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
	--~ love.physics.setMeter(32)
	--~ world = love.physics.newWorld(0, 0)
    world = wf.newWorld(0, 0, true)
    world:setGravity(0, 512)
    world:addCollisionClass('Player')

	--~ map:box2d_init(world)

	points = {
	}
	love.graphics.setPointSize(5)
	love.window.setMode((world_width+1) * tile_size, (world_height+1) * tile_size)

    map:registerCollision(world, 'Player')
    map:refresh(grid)
end

function love.keypressed(key)
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
	love.graphics.setColor(255, 0, 255)
	for _, point in ipairs(points) do
        local cx,cy = point.collider:getPosition()
		love.graphics.circle('fill', cx, cy, point.radius)
	end
end

function love.mousepressed(x, y, button)
	if button == 1 then
        local r = 10
        local ball = world:newCircleCollider(x, y, r)
        ball:setRestitution(0.8)
        ball:setCollisionClass('Player')
        ball:applyLinearImpulse(500, 500)

        table.insert(points, {
                radius = r,
                collider = ball,
            })
	end
end

function love.resize(w, h)
	--~ map:resize(w, h)
end
