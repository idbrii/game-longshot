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
    cool_downs = {
        launcher = 10,
        resourcer = 7,
        barracks = 5,
        bomb = 0.75
    },
    mass = {
      launcher = 0.75,
      resourcer = 0.75,
      barracks = 0.75,
      bomb = 0.25,
    },
    timer = {
        projectile = {
            max_lifetime = 10,
            -- can't be too small or might die during initial spawn and fall
            max_idle_lifetime = 0.95,
        },
    },
}
return tuning
