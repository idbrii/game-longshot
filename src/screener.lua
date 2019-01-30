-- screener: Convenience wrapper around push.

local push = require "push.push"
local screener = {}

-- Call from love.load
-- window_cfg = {
--     fullscreen = true,
--     position = {x,y, display} -- nil will be centred on main
--     scale = 0.5, -- [0,1]
-- },
function screener.setupScreen(game_width, game_height, window_cfg)
    local window_width, window_height = love.window.getDesktopDimensions()
    local push_cfg = {
        fullscreen = window_cfg.fullscreen,
        resizable = false, -- doesn't seem to work
        canvas = true,
        pixelperfect = true,
    }
    if not window_cfg.fullscreen then
        -- Scale only makes sense in not fullscreen.
        local scale = window_cfg.scale
        if scale then
            window_width, window_height = window_width * scale, window_height * scale
        end
        -- For some reason pixelperfect produces black window except in
        -- fullscreen.
        push_cfg.pixelperfect = false
    end
    push:setupScreen(game_width, game_height, window_width, window_height, push_cfg)
    if window_cfg.position then
        -- push stomps some window values, so after setupScreen, we can set
        -- position.
        love.window.setPosition(unpack(window_cfg.position))
    end
end

function screener.getMousePosition()
    return push:toGame(love.mouse.getPosition())
end

function screener.getDimensions()
    return push:getDimensions()
end

function screener.draw(fn)
    push:start()
    fn()
    push:finish()
end

function screener.resize(...)
    push:resize(...)
end

return screener
