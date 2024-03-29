-- Not sure best way to organize code. For now, main in project root, all code
-- in src, libraries in src/lib/
love.filesystem.setRequirePath("src/?.lua;src/?/init.lua;src/lib/?.lua;src/lib/?/init.lua")


local is_web = love.system.getOS() == 'Web'
if is_web
    then
    -- HACK: audio is breaking the web build. Probably static vs dynamic.
    -- Disable sound for now.
    love.audio = nil
end

io.stdout:setvbuf("no")
local devcheck = require "devcheck"
local Bomb = require('bomb')
local Damagable = require("damagable")
local TileMap = require("tilemap")
local pl_table = require('pl.tablex')
local Vec = require('hump.vector')
local screener = require "screener"
local Sound = require('sound')
local tuning = require('tuning')
local Vfx = require('vfx')
local Player = require('player')
local PreviewProjectile = require "previewprojectile"
local Projectile = require('projectile')
local moretable = require('moretable')
local gridgen = require("gridgen")
local wf = require("windfield")
local baton = require "baton.baton"
local Resourcer = require("resourcer")
local Barracks = require("barracks")
local ClaimsManager = require("claims_manager")
local Launcher = require('launcher')
local Tech = require('tech')
local Sensor = require('sensor')

local k_default_blend = 6

local gamestate = {
    -- grid: true if tile is solid. false if empty.
    -- input: menu input
    -- map: tiles
    -- world: windfield physics world
    -- entities: objects in the world
    -- claims: the ClaimsManager instance
}
gamestate.config = {
    world_width = 50,
    world_height = 28,
    tile_size = 32,
    bottom_ui_height = 50,
    foreground_blend_index = k_default_blend,
    has_cheats = devcheck.isDev(),
}

local should_draw_physics = false


function love.load()
    love.graphics.setDefaultFilter('nearest', 'nearest', 16)

    love.joystick.loadGamepadMappings("assets/gamepad/gamecontrollerdb.txt")

    local game_width, game_height = (gamestate.config.world_width+1) * gamestate.config.tile_size, ((gamestate.config.world_height+1) * gamestate.config.tile_size) + gamestate.config.bottom_ui_height
    screener.setupScreen(game_width, game_height, tuning.window_cfg)

    -- Don't show title card for developers.
    gamestate.show_titlecard = not gamestate.config.has_cheats

    gamestate.menu_input = baton.new {
        controls = {
            quit = {'key:escape'},
            fullscreen = {'key:return'}, -- and alt
            draw_physics = {'key:backspace'},
        },
    }

    gamestate.entities = {}
    gamestate.addEntity = function(state, ent)
        table.insert(gamestate.entities, ent)
    end
    gamestate.removeEntity = function(state, ent)
        local idx = pl_table.find(gamestate.entities, ent)
        table.remove(gamestate.entities, idx)
    end
    gamestate.onDie_cb = {} -- function(victim)
    gamestate.onLose = function(state, loser)
        if loser.index == 1 then
            gamestate.winner = gamestate.players[2]
        else
            gamestate.winner = gamestate.players[1]
        end
    end


    -- Prepare physics world
    --~ love.physics.setMeter(32)
    gamestate.world = wf.newWorld(0, 0, true)
    gamestate.world:setGravity(0, 512)
    gamestate.world:addCollisionClass('SoldiersP1',               {ignores={'SoldiersP1'}})
    gamestate.world:addCollisionClass('SoldiersP2',               {ignores={'SoldiersP2'}})
    gamestate.world:addCollisionClass(Projectile.collision_class)

    gamestate.plates = {}
    gamestate.plates.titlecard = love.graphics.newImage("assets/textures/titlecard.png")
    gamestate.plates.skybox = love.graphics.newImage("assets/textures/skybox.png")
    gamestate.plates.foreground = love.graphics.newImage("assets/textures/ground_overlay.png")
    gamestate.plates.ui_bg = love.graphics.newImage("assets/textures/ui_background.png")
    gamestate.plates.winner = love.graphics.newImage("assets/textures/winner.png")

    gamestate.art = {
        resourcer = love.graphics.newImage("assets/sprites/resourcer/deployed.png"),
        barracks = love.graphics.newImage("assets/sprites/barracks/deployed.png"),
        launcher = love.graphics.newImage("assets/sprites/launcher/deployed.png"),
        launcher_arm = love.graphics.newImage("assets/sprites/launcher/aimer.png"),
        balls =
        {
            bomb = love.graphics.newImage("assets/textures/bomb.png"),
            resourcer = love.graphics.newImage("assets/sprites/resourcer/ball.png"),
            barracks = love.graphics.newImage("assets/sprites/barracks/ball.png"),
            launcher = love.graphics.newImage("assets/sprites/launcher/ball.png"),
        },
    }

    -- same art for both
    gamestate.art.bomb = gamestate.art.balls.bomb

    gamestate.grid = gridgen.generate_grid(gamestate.config.world_width, gamestate.config.world_height)
    gamestate.map = TileMap:new(
        gamestate,
        love.graphics.newImage("assets/textures/Floor.png"),	-- Pure grass tile
        love.graphics.newImage("assets/textures/Autotile.png"), -- Autotile image
        gamestate.config.tile_size,
        gamestate.config.world_width,
        gamestate.config.world_height
        )
    gamestate.map:registerCollision(gamestate.world, Damagable.collision_classes)
    gamestate.world:addCollisionClass(Sensor.collision_class, {ignores={'Block', 'Ghost'}})
    local ghost_ignore = {
        -- everything but Block
        ignores = {
            PreviewProjectile.collision_class,
            Projectile.collision_class,
            Sensor.collision_class,
            "Ghost",
            "SoldiersP1",
            "SoldiersP2",
        },
    }
    gamestate.world:addCollisionClass(PreviewProjectile.collision_class, ghost_ignore)
    gamestate.map:fixupGrid(gamestate.grid)

    ClaimsManager:new(gamestate)
    
    Vfx.load()
    Launcher.load()
    Sound.load()


    -- Print versions
    print("ESCAPE TO QUIT")

    love.graphics.setPointSize(5)
    gamestate.players = {
        Player(gamestate, 1),
        Player(gamestate, 2),
    }

    local starts = {}
    starts.p1, starts.p2 = gamestate.map:buildStartPoints(gamestate.grid)
    Launcher:new(gamestate, gamestate.players[1], starts.p1.x,starts.p1.y, {techEffect = Tech.Effects.Basic})
    Launcher:new(gamestate, gamestate.players[2], starts.p2.x,starts.p2.y, {techEffect = Tech.Effects.Basic})
    gamestate.map:refresh(gamestate.grid)
end

function love.gamepadpressed(joystick)
    for _,player in ipairs(gamestate.players) do
        if player:isUsingGamepad(joystick) then
            return
        end
    end
    -- reverse iterate to give priority to non mouse user.
    for i in ipairs(gamestate.players) do
        local rev_i = #gamestate.players - i + 1
        local player = gamestate.players[rev_i]
        local consumed = player:tryAssignGamepad(joystick)
        if consumed then
            break
        end
    end
end

local min_time_to_display_winner = 3
function love.joystickpressed(key)
    gamestate.show_titlecard = false

    if gamestate.winner_duration and gamestate.winner_duration > min_time_to_display_winner then
        love.event.quit('restart')
    end
end

function love.keypressed(key)
    gamestate.show_titlecard = false

    if not gamestate.config.has_cheats then
        return
    end

    if gamestate.winner_duration
        and gamestate.winner_duration > min_time_to_display_winner
        and (key:len() > 1 or key == 'space') -- letter/number keys to avoid special keys like trying to take a screenshot
        then
        love.event.quit('restart')
    end

    if key == 'b' then
        gamestate.config.foreground_blend_index = moretable.circular_index_number(8, gamestate.config.foreground_blend_index + 1)
    elseif key == 'v' then
        Sound.setDanger()
    elseif key == 'y' and (love.keyboard.isDown("lshift") or love.keyboard.isDown("rshift")) then
        gamestate.winner = gamestate.players[2]
    elseif key == 'y' then
        gamestate.winner = gamestate.players[1]
    end
end

function love.update(dt)
    if gamestate.winner then
        if gamestate.winner_duration then
            gamestate.winner_duration = gamestate.winner_duration + dt
        else
            gamestate.winner_duration = 0
        end
    end

    gamestate.menu_input:update()

    if gamestate.menu_input:pressed('quit') then
        love.event.quit()
    elseif gamestate.menu_input:pressed('fullscreen') and love.keyboard.isDown('ralt', 'lalt') then
        print("Toggling fullscreen")
        screener.toggleFullscreen()
        love.resize(love.graphics.getDimensions())
    elseif gamestate.menu_input:pressed('draw_physics') then
        should_draw_physics = not should_draw_physics
    end

    Sound.update(dt)

    gamestate.world:update(dt)
    --~ gamestate.map:update(dt)

    for _, ent in ipairs(gamestate.entities) do
        ent:update(dt, gamestate)
    end
end

local function main_draw(...)

    local screen_w, screen_h = screener.getDimensions()

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

    if gamestate.show_titlecard then
        local sprite = gamestate.plates.titlecard
        local w,h = sprite:getDimensions()
        love.graphics.draw(sprite,
            screen_w/2, screen_h/2,
            nil,
            nil, nil,
            w/2, h/2)
        return
    end


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
    love.graphics.draw(sprite, 0, screen_h - gamestate.config.bottom_ui_height)

    -- Draw entities
    love.graphics.setColor(1,1,1)
    for _, ent in ipairs(gamestate.entities) do
        ent:draw(gamestate)
    end

    if mode and gamestate.config.foreground_blend_index ~= k_default_blend then
        love.graphics.setColor(0, 100, 100)
        love.graphics.print(mode[1] ..' '.. mode[2], 10,10)
    end

    if gamestate.winner then
        Sound.setWinner()

        -- tint
        love.graphics.setColor(1,1,1,0.3)
        love.graphics.rectangle('fill',
            0,0,
            screen_w, screen_h)

        -- winner image
        sprite = gamestate.plates.winner
        local w,h = sprite:getDimensions()
        love.graphics.setColor(gamestate.winner:getColour())
        love.graphics.draw(sprite,
            screen_w/2, screen_h/2,
            nil,
            nil, nil,
            w/2, h/2)
        --~ love.graphics.print('Winner is P'.. gamestate.winner.index, screen_w/2, screen_h/2-(h/2+50))
    end

    -- Draw physics objects
    love.graphics.setColor(1,1,1)
    if should_draw_physics then
        gamestate.world:draw()
    end

    if gamestate.debug_draw_fn then
        gamestate.debug_draw_fn()
    end
end

function love.draw()
    screener.draw(main_draw)
end


function love.mousepressed(_, _, button)
    local x,y = screener.getMousePosition()
    gamestate.show_titlecard = false

    -- confine mouse to window
    love.mouse.setGrabbed(true)

    if not gamestate.config.has_cheats then
        return
    end

    if button == 1 or button == 2 then
        if gamestate.config.has_cheats  then
            if love.keyboard.isDown("lshift") then
                Resourcer:new(gamestate, gamestate.players[1], x, y, {techEffect = gamestate.players[1].tech.selectedEffect})
            elseif love.keyboard.isDown("rshift") then
                Resourcer:new(gamestate, gamestate.players[2], x, y, {techEffect = gamestate.players[2].tech.selectedEffect})
            elseif love.keyboard.isDown("lctrl") then
                Barracks:new(gamestate, gamestate.players[1], x, y, {techEffect = gamestate.players[1].tech.selectedEffect})
            elseif love.keyboard.isDown("rctrl") then
                Barracks:new(gamestate, gamestate.players[2], x, y, {techEffect = gamestate.players[2].tech.selectedEffect})
            end
        end


    elseif button == 3 then
        if love.keyboard.isDown("lshift") then
            Bomb:new(gamestate, gamestate.players[1], x, y, {techEffect = Tech.Effects.Basic})
        else
            -- Remove collision
            local grid_pos = gamestate.map:toGridPosVector(Vec(x,y))
            print("Removed collision from tile:", grid_pos.x, grid_pos.y)
            gamestate.grid[grid_pos.x][grid_pos.y] = love.keyboard.isDown("lctrl")
            gamestate.map:refresh(gamestate.grid)
        end
    end
end

function love.resize(w, h)
    screener.resize(w, h)
end
