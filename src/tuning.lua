local tuning = {
    health = {
        launcher = 50,
        resourcer = 50,
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
    timer = {
        projectile = {
            max_lifetime = 10,
            -- can't be too small or might die during initial spawn and fall
            max_idle_lifetime = 0.85,
        },
    },
}
return tuning
