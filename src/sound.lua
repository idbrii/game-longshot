local sone = require('sone.sone')

local Sound = {}

local k_time_to_focus = 10

local function makeSound(key)
    Sound[key].source = love.audio.newSource(Sound[key].sound)
    Sound[key].source :setLooping(true)
end

function Sound.load()
    if not love.audio then
        return
    end
    Sound.music_danger = {sound = love.sound.newSoundData('assets/audio/song_focus.mp3')}
    Sound.music_focus = {sound = love.sound.newSoundData('assets/audio/song_danger.mp3')}
    makeSound("music_danger")
    makeSound("music_focus")

    Sound.time_since_danger = 0
    Sound.is_danger = false

    sone.fadeIn(Sound.music_focus.sound, 5)
    Sound.music_focus.source:play()
end

function Sound.update(dt)
    if not love.audio then
        return
    end
    Sound.time_since_danger = Sound.time_since_danger + dt

    if Sound.time_since_danger > k_time_to_focus then
        Sound.is_danger = false
        Sound._switchToDanger(false)
    end
end

function Sound.setWinner()
    if not love.audio then
        return
    end
    if Sound.is_winner then
        return
    else
        Sound.is_winner = true
        Sound.music_danger.source:play()
        Sound.music_focus.source:stop()
    end
end

function Sound.setDanger()
    if not love.audio then
        return
    end
    if Sound.is_danger then
        print('more danger')
        Sound.time_since_danger = 0
    else
        print('detected danger')
        Sound._switchToDanger(true)
    end
end

function Sound._switchToDanger(is_danger)
    -- TODO: Looks like sone's fading doesn't actually work? We'll have to
    -- start with just the focus music.
    Sound.is_danger = is_danger
    if is_danger then
        --~ Sound.music_danger.source:play()
        sone.fadeIn(Sound.music_danger.sound, 3)
        sone.fadeOut(Sound.music_focus.sound, 1)
    else
        sone.fadeIn(Sound.music_focus.sound, 3)
        sone.fadeOut(Sound.music_danger.sound, 1)
    end
end

return Sound
