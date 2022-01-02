local devcheck = require "./src/devcheck"

function love.conf(t)
    t.identity     = 'longshot' -- The name of the save directory (string)
    t.version      = '11.3'     -- The LÖVE version this game was made for (string)
    t.console      = true       -- Attach a console (boolean, Windows only)
    t.window.title = 'Longshot' -- The window title (string)
    local user = devcheck.getUser()
    if devcheck.isDebug() and user == 'dbriscoe' then
        -- disable music (and all sounds)
        t.modules.audio = false
    end

    -- Configure window with push in love.load and not here.
    t.window.fullscreen = false
    --~ t.window.x = nil   --  The x-coordinate of the window's position in the specified display (number)
    --~ t.window.y = nil   --  The y-coordinate of the window's position in the specified display (number)
    --~ t.window.width = nil                -- The window width (number)
    --~ t.window.height = nil               -- The window height (number)
end
