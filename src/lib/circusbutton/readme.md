Source: https://love2d.org/forums/viewtopic.php?t=80727

How to use it :

1. hire the circus!

    local circusButtons = require("circusButton")

2. Setup the circus!

    function love.load()
        circusButtons.addButton("MyButton1",function() print("omg buttons") end)
        circusButtons.addButton("MyButton2",function() print("omg buttons again") end)
        circusButtons.addButton("Dank Button",function() print("Dank Buttons") end)
        circusButtons.addButton("To_button_or",function() print("ThatIsTheQuestion") end)
    end
    
    function love.update(dt)
        circusButtons.update()
    end
    
    function love.mousepressed(x,y,b)
        circusButtons.onClick()
    end
    
    function love.draw()
        circusButtons.render()
    end

3. Decide when to put on a show or not!

    function love.keypressed(key, unicode)
        if(key == "a") then
            circusButtons.setState(true)
        end
        if(key == "b") then
            circusButtons.setState(false)
        end

important Functions :

## setState(bool state)
Sets whether mouse hover over or clicks are checked against buttons. Also sets whether it is rendered or not.

## addButton(string Name,function onClick_fn)
Adds a new button and adjusts accordingly. 
onClick_fn is called when the button is clicked.
Name specifies the string to display on hover over.

## update()
Updates the button.

## render()
Renders the button, and if any buttons are hovered - the string name below the circusButton

## setPosition(number x,number y)
Sets where the circus button renders on screen. Useful to render at mouse once, or if you are funny... Follow the mouse ;)

## getHoverAt(number x,number y)
Internally used, Externally accessible.
@Returns a table representing a button at x,y on screen.
@Returns false if no button exists at x,y on screen.
Useful for modify buttons dynamically.


Pros :
1. Simple to use!

Cons :
1. Cant set draw Colors(yet)
2. Cant remove a button(yet)
3. Cant have more than one type of circus button (Not OO implementation) (yet)
4. Others I've not been made aware of

In the future [Promoting the clowns!]
1. OO implementation for buttons and radials for multi-instance support.
populate a single radial and then toggle buttons as needed. this prevents head way related to adding and removing button objects.
2. button:setState(bool state)
will set whether that button on its radial menu is used or not (rendered).
3. button:destroy()
delete button object completely. Useful only if the button is expected to never be used again (since setState can disable it temp)
