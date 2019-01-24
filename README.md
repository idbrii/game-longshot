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
* w     - up
* a     - left
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
* up    - up
* left  - left
* down  - down
* right - right
* [     - cycle_launcher_left
* ]     - cycle_launcher_right
* 7     - mod_normal
* 8     - mod_bouncy
* 9     - mod_boosty
* 0     - mod_sticky

or gamepad:

* leftstick     - aim
* fdown         - fire
* dpup          - up
* dpleft        - left
* dpdown        - down
* dpright       - right
* leftshoulder  - cycle_launcher_left
* rightshoulder - cycle_launcher_right
* back          - mod_normal
* fleft         - mod_bouncy
* fup           - mod_boosty
* fright        - mod_sticky

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
