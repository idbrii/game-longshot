# game-longshot

Like Worms mixed with Moonbase Commander.

## Summary

You launch RTS buildings instead of missiles. You start with one launcher
building that can fire mineshafts (get resources), barracks (pump out creeps),
bombs (terraform/defence), or more launchers. Tech tree lets you make them
bouncy, boosty, sticky.

## Controls
See also player.lua: Player:getPrettyInput()

### Gamepad

* Fire: Right Shoulder
* Aim: Left Stick
* Cycle Launcher Left: D-pad left
* Cycle Launcher Right: Left Shoulder
* Cycle Projectile Next: D-pad down
* Cycle Projectile Previous: D-pad up
* Normal Tech: A
* Sticky Tech: B
* Bouncy Tech: X
* Boosty Tech: Y

### Keyboard - Player 1

* Fire: space
* Aim: mouse
* Aim Left: a
* Aim Right: d
* Cycle Launcher Left: q
* Cycle Launcher Right: e
* Cycle Projectile Next: s
* Cycle Projectile Previous: w
* Normal Tech: 1
* Bouncy Tech: 2
* Boosty Tech: 3
* Sticky Tech: 4


### Keyboard - Player 2

* Fire: rctrl
* Aim Left: left
* Aim Right: right
* Cycle Launcher Left: [
* Cycle Launcher Right: ]
* Cycle Projectile Next: down
* Cycle Projectile Previous: up
* Sticky Tech: 0
* Normal Tech: 7
* Bouncy Tech: 8
* Boosty Tech: 9


## Running

### Dependencies 
```bash
sudo add-apt-repository ppa:bartbes/love-stable
sudo apt-get update
sudo apt-get install love
```
(Or download from https://love2d.org/)


### Launching

```bash
love .
```

# Music Credits

* [Space Arp F Chords.wav](https://freesound.org/people/esistnichtsoernst/sounds/473996/) by [esistnichtsoernst](https://freesound.org/people/esistnichtsoernst/) | License: Creative Commons 0
* [Dramatic Uprising Pulse Ambience](https://freesound.org/people/PatrickLieberkind/sounds/395388/) by [PatrickLieberkind](https://freesound.org/people/PatrickLieberkind/) | License: Attribution
