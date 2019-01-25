# game-longshot

Like Worms mixed with Moonbase Commander.

## Summary

You launch RTS buildings instead of missiles. You start with one launcher
building that can fire mineshafts (get resources), barracks (pump out creeps),
bombs (terraform/defence), or more launchers. Tech tree lets you make them
bouncy, boosty, sticky.

## Controls
See also player.lua: defineKeyboardInput and defineGamepadInput.

### Player 1
aim with mouse

* space - fire
* w     - cycle_projectile_prev
* a     - cycle_projectile_next
* s     - down
* d     - right
* q     - cycle_launcher_left
* e     - cycle_launcher_right
* 1     - mod_normal
* 2     - mod_bouncy
* 3     - mod_boosty
* 4     - mod_sticky

### Player 2
* rctrl - fire
* up    - cycle_projectile_prev
* down  - cycle_projectile_next
* left  - left
* right - right
* [     - cycle_launcher_left
* ]     - cycle_launcher_right
* 7     - mod_normal
* 8     - mod_bouncy
* 9     - mod_boosty
* 0     - mod_sticky

or gamepad:

* r1      - fire
* l1      - cycle_launcher_right
* dpup    - cycle_projectile_prev
* dpdown  - cycle_projectile_next
* dpleft  - cycle_launcher_left
* dpright - cycle_launcher_right
* fdown   - mod_normal
* fleft   - mod_bouncy
* fup     - mod_boosty
* fright  - mod_sticky

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
