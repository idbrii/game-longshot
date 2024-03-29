local devcheck = require('devcheck')

local tuning = {
    window_cfg = {
        fullscreen = true,
        position = nil, -- {x,y, display} default is centred on main
        scale = nil, -- [0,1]
    },
    health = {
        launcher = 1000,
        resourcer = 1000,
        barracks = 1000,
        bomb = 10,
        soldier = 50,
    },
    damage_dealer = {
        launcher = 10,
        resourcer = 10,
        barracks = 10,
        bomb = 100,
        soldier = 25,
    },
    cool_downs = {
        launcher = 5,
        resourcer = 5,
        barracks = 5,
        bomb = 0.75
    },
    mass = {
      launcher = 0.5,
      resourcer = 0.5,
      barracks = 0.5,
      bomb = 0.25,
      soldier = 0.61,
    },
    size = {
        bomb = {
            blast_radius = 50,
        },
        radius = {
            launcher = 30,
            resourcer = 32,
            barracks = 32,
            bomb = 10,
            soldier = 10,
        },
    },
    timer = {
        projectile = {
            max_lifetime = 15,
            -- can't be too small or might die during initial spawn and fall
            max_idle_lifetime = 0.95,
        },
    },
    projectile = {
        minSpeed = 400,
        boostForce = 200
    }
}

-- Devs can set local preferences here.
if devcheck.isDebug() then
    local user = devcheck.getUser()
    if user == 'dbriscoe' then
        tuning.window_cfg.fullscreen = false
        tuning.window_cfg.position = { 0,0, 2 }
        tuning.window_cfg.scale = 0.8
    end
end

return tuning
