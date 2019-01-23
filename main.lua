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


local tx, ty

local gamestate = {}
gamestate.config = {
    world_width = 50,
    world_height = 30,
    tile_size = 32,
}

function love.load()
    gamestate.input = Input()
    gamestate.input:bind('q', love.event.quit)
    gamestate.input:bind('escape', love.event.quit)

    gamestate.grid = gridgen.generate_grid(gamestate.config.world_width, gamestate.config.world_height)
	gamestate.map = TileMap:new(
		love.graphics.newImage("assets/textures/Floor.png"),	-- Pure grass tile
		love.graphics.newImage("assets/textures/Autotile.png"), -- Autotile image
		gamestate.config.tile_size,
		gamestate.config.world_width,
		gamestate.config.world_height
		)

	-- Print versions
	print("ESCAPE TO QUIT")
	print("SPACE TO RESET TRANSLATION")

	-- Prepare translations
	tx, ty = 0, 0

	-- Prepare physics world
	--~ love.physics.setMeter(32)
	--~ gamestate.world = love.physics.newWorld(0, 0)
    gamestate.world = wf.newWorld(0, 0, true)
    gamestate.world:setGravity(0, 512)
    gamestate.world:addCollisionClass('Player')

	--~ gamestate.map:box2d_init(gamestate.world)

	gamestate.entities = {}

	love.graphics.setPointSize(5)
	love.window.setMode((gamestate.config.world_width+1) * gamestate.config.tile_size, (gamestate.config.world_height+1) * gamestate.config.tile_size)

    gamestate.map:registerCollision(gamestate.world, 'Player')
    gamestate.map:refresh(gamestate.grid)
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

	gamestate.world:update(dt)
	--~ gamestate.map:update(dt)

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
	gamestate.map:draw(gamestate.grid)

	-- Draw physics objects
	love.graphics.setColor(255, 0, 255)
	gamestate.map:box2d_draw(-tx, -ty)

	-- Draw entities
	love.graphics.setColor(255, 0, 255)
	for _, ent in ipairs(gamestate.entities) do
        local cx,cy = ent.collider:getPosition()
		love.graphics.circle('fill', cx, cy, ent.radius)
	end
end

function love.mousepressed(x, y, button)
	if button == 1 then
        local r = 10
        local ball = gamestate.world:newCircleCollider(x, y, r)
        ball:setRestitution(0.8)
        ball:setCollisionClass('Player')
        ball:applyLinearImpulse(500, 500)

        table.insert(gamestate.entities, {
                radius = r,
                collider = ball,
            })
	end
end

function love.resize(w, h)
	--~ gamestate.map:resize(w, h)
end
