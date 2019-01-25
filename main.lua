-- Not sure best way to organize code. For now, main in project root, all code
-- in src, libraries in src/lib/
love.filesystem.setRequirePath("src/?.lua;src/?/init.lua;src/lib/?.lua;src/lib/?/init.lua")
-- Monkey patch graphics to auto batch sprites.
-- TODO(dbriscoe): Maybe using out-of-date love api, but autobatch fails on
-- setBufferSize.
--~ require("rxi.autobatch")

io.stdout:setvbuf("no")
local TileMap = require("tilemap")
local pl_table = require('pl.tablex')
local Vec = require('hump.vector')
local Sound = require('sound')
local Vfx = require('vfx')
local Player = require('player')
local Projectile = require('projectile')
local moretable = require('moretable')
local KillVolume = require('killvolume')
local gridgen = require("gridgen")
local wf = require("windfield")
local Input = require('boipushy.Input')
local Resourcer = require("resourcer")
local Barracks = require("barracks")
local ClaimsManager = require("claims_manager")
local Launcher = require('launcher')


local gamestate = {
    -- grid: true if tile is solid. false if empty.
    -- input: boipushy input
    -- map: tiles
    -- world: windfield physics world
    -- entities: objects in the world
    -- claims: the ClaimsManager instance
}
gamestate.config = {
    world_width = 50,
    world_height = 30,
    tile_size = 32,
    foreground_blend_index = 6,
}

local debug_draw_fn
local should_draw_physics = false

function love.load()
    gamestate.input = Input()
    gamestate.input:bind('escape', love.event.quit)
    gamestate.input:bind('backspace', function()
        should_draw_physics = not should_draw_physics
    end)

    gamestate.entities = {}
    gamestate.addEntity = function(state, ent)
        table.insert(gamestate.entities, ent)
    end
    gamestate.removeEntity = function(state, ent)
        local idx = pl_table.find(gamestate.entities, ent)
        table.remove(gamestate.entities, idx)
    end
    gamestate.onDie_cb = {} -- function(victim)


    -- Prepare physics world
    --~ love.physics.setMeter(32)
    --~ gamestate.world = love.physics.newWorld(0, 0)
    gamestate.world = wf.newWorld(0, 0, true)
    gamestate.world:setGravity(0, 512)
    local nonblock_collision_classes = {
        'SoldiersP1',
        'SoldiersP2',
        KillVolume.collision_class,
        Projectile.collision_class,
    }
    gamestate.world:addCollisionClass('SoldiersP1',               {ignores={'SoldiersP1'}})
    gamestate.world:addCollisionClass('SoldiersP2',               {ignores={'SoldiersP2'}})
    gamestate.world:addCollisionClass(KillVolume.collision_class)
    gamestate.world:addCollisionClass(Projectile.collision_class)


    gamestate.plates = {}
    gamestate.plates.skybox = love.graphics.newImage("assets/textures/skybox.png")
    gamestate.plates.foreground = love.graphics.newImage("assets/textures/ground_overlay.png")
    gamestate.plates.ui_bg = love.graphics.newImage("assets/textures/ui_background.png")

    gamestate.art = {
        bomb = love.graphics.newImage("assets/textures/bomb.png"),
        resourcer = love.graphics.newImage("assets/sprites/resourcer/deployed.png"),
        barracks = love.graphics.newImage("assets/sprites/barracks/deployed.png"),
        launcher = love.graphics.newImage("assets/textures/launcher.png"),
        launcher_arm = love.graphics.newImage("assets/textures/launcher_aimer.png"),
    }

    gamestate.grid = gridgen.generate_grid(gamestate.config.world_width, gamestate.config.world_height)
    gamestate.map = TileMap:new(
        gamestate,
        love.graphics.newImage("assets/textures/Floor.png"),	-- Pure grass tile
        love.graphics.newImage("assets/textures/Autotile.png"), -- Autotile image
        gamestate.config.tile_size,
        gamestate.config.world_width,
        gamestate.config.world_height
        )
    gamestate.map:registerCollision(gamestate.world, nonblock_collision_classes)
    gamestate.map:fixupGrid(gamestate.grid)

    ClaimsManager:new(gamestate)
    
    Vfx.load()
    Launcher.load()
    Sound.load()


    -- Print versions
    print("ESCAPE TO QUIT")

    --~ gamestate.map:box2d_init(gamestate.world)

    -- If we want to change grid size, we'll need to get the numbers.
    --~ love.window.setMode((gamestate.config.world_width+1) * gamestate.config.tile_size, (gamestate.config.world_height+1) * gamestate.config.tile_size)
    --~ print((gamestate.config.world_width+1) * gamestate.config.tile_size, (gamestate.config.world_height+1) * gamestate.config.tile_size)

    love.graphics.setPointSize(5)
    gamestate.players = {
        Player(gamestate, 1),
        Player(gamestate, 2),
    }

    Player.defineKeyboardInput(gamestate)

    local starts = {}
    starts.p1, starts.p2, debug_draw_fn = gamestate.map:buildStartPoints(gamestate.grid)
    Launcher:new(gamestate, gamestate.players[1], starts.p1.x,starts.p1.y)
    Launcher:new(gamestate, gamestate.players[2], starts.p2.x,starts.p2.y)
    gamestate.map:refresh(gamestate.grid)
end

function love.joystickadded(joystick)
    Player.defineGamepadInput(gamestate)
end

function love.keypressed(key)
    if key == 'b' then
        gamestate.config.foreground_blend_index = moretable.circular_index_number(8, gamestate.config.foreground_blend_index + 1)
    elseif key == 'v' then
        Sound.setDanger()
    end
end

function love.update(dt)
    -- hot reload code
    --~ require("rxi.lurker").update()

    Sound.update(dt)

    gamestate.world:update(dt)
    --~ gamestate.map:update(dt)

    for _, ent in ipairs(gamestate.entities) do
        ent:update(dt, gamestate)
    end

    -- Move map
    local kd = love.keyboard.isDown
    local l  = kd("left")  or kd("a")
    local r  = kd("right") or kd("d")
    local u  = kd("up")    or kd("w")
    local d  = kd("down")  or kd("s")

    --~ tx = l and tx - 128 * dt or tx
    --~ tx = r and tx + 128 * dt or tx
    --~ ty = u and ty - 128 * dt or ty
    --~ ty = d and ty + 128 * dt or ty
end

function love.draw()
    local screen_w, screen_h = love.graphics.getWidth(), love.graphics.getHeight()
    local blendmodes = {
        { 'alpha', 'alphamultiply' },
        { 'alpha', 'premultiplied' },
        { 'replace', 'alphamultiply' },
        { 'replace', 'premultiplied' },
        { 'screen', 'alphamultiply' },
        { 'screen', 'premultiplied' },
        { 'add', 'alphamultiply' },
        { 'add', 'premultiplied' },
        { 'subtract', 'alphamultiply' },
        { 'subtract', 'premultiplied' },
        { 'multiply', 'premultiplied' },
        { 'lighten', 'premultiplied' },
        { 'darken', 'premultiplied' },
        false, -- don't draw at all
    }

    love.graphics.setColor(1,1,1)
    love.graphics.draw(gamestate.plates.skybox, 0, 0)

    -- Draw map
    gamestate.map:draw(gamestate.grid)

    local mode = blendmodes[gamestate.config.foreground_blend_index]
    if mode then
        love.graphics.setBlendMode(unpack(mode))
        love.graphics.draw(gamestate.plates.foreground, 0, 0)
    end
    -- restore default
    love.graphics.setBlendMode('alpha', 'alphamultiply')

    love.graphics.setColor(1,1,1)
    local sprite = gamestate.plates.ui_bg
    love.graphics.draw(sprite, 0, screen_h-50)

    -- Draw entities
    love.graphics.setColor(1,1,1)
    for _, ent in ipairs(gamestate.entities) do
        ent:draw(gamestate)
    end

    if mode then
        love.graphics.setColor(0, 100, 100)
        love.graphics.print(mode[1] ..' '.. mode[2], 10,10)
    end

    -- Draw physics objects
    love.graphics.setColor(1,1,1)
    if should_draw_physics then
        gamestate.world:draw()
    end

    if debug_draw_fn then
        debug_draw_fn()
    end
end

function love.mousepressed(x, y, button)

    if button == 1 or button == 2 then
        if love.keyboard.isDown("lshift") then
            Resourcer:new(gamestate, gamestate.players[1], x, y)
        elseif love.keyboard.isDown("rshift") then
            Resourcer:new(gamestate, gamestate.players[2], x, y)
        elseif love.keyboard.isDown("lctrl") then
            Barracks:new(gamestate, gamestate.players[1], x, y)
        elseif love.keyboard.isDown("rctrl") then
            Barracks:new(gamestate, gamestate.players[2], x, y)
        end

    elseif button == 3 then
        -- Remove collision
        local grid_pos = gamestate.map:toGridPosVector(Vec(x,y))
        gamestate.grid[grid_pos.x][grid_pos.y] = false
        gamestate.map:refresh(gamestate.grid)
    end
end

function love.resize(w, h)
    --~ gamestate.map:resize(w, h)
end
