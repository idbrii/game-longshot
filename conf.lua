local function getUser()
    return os.getenv('USERNAME') or os.getenv('USER') or 'generic'
end

function love.conf(t)
    t.identity     = 'longshot' -- The name of the save directory (string)
    t.version      = '11.2'     -- The LÖVE version this game was made for (string)
    t.console      = true       -- Attach a console (boolean, Windows only)
    t.window.title = 'Longshot' -- The window title (string)
    local user = getUser()
    if user == 'David' then
        t.window.x = 2580  --  The x-coordinate of the window's position in the specified display (number)
        t.window.y = 190   --  The y-coordinate of the window's position in the specified display (number)
    elseif user == 'dbriscoe' then
        -- disable music (and all sounds)
        t.modules.audio = false
    elseif user == 'ruy' then
        t.window.x = 2000  --  The x-coordinate of the window's position in the specified display (number)
        t.window.y = nil   --  The y-coordinate of the window's position in the specified display (number)
    else
        t.window.x = nil   --  The x-coordinate of the window's position in the specified display (number)
        t.window.y = nil   --  The y-coordinate of the window's position in the specified display (number)
    end
    t.window.width = 1632                -- The window width (number)
    t.window.height = 928+50               -- The window height (number)
end
