-- Source: https://love2d.org/forums/viewtopic.php?t=80727
local CButton = {}
CButton.radius = 80
CButton.buttons = {}
CButton.state = false
CButton.vec2 = {100,100}



function CButton.addButton(name,onClick_fn)
 CButton.buttons[#CButton.buttons+1] = {name=name,fn=onClick_fn,angles={nil,nil}}
 CButton.update()
end

function CButton.getHoverAt(x,y)
 local pos = {CButton.getPosition()}
 local buttonOver = false
 if math.sqrt( ( pos[1] - x ) ^ 2 + ( pos[2] - y ) ^ 2 ) <= CButton.radius then
  local angle = math.deg(math.atan2(y-pos[2],x-pos[1]))+180
  for k,v in pairs(CButton.buttons) do
   if v.angles[1] <= angle and v.angles[2] >= angle then
    buttonOver = k
    break
   end
  end
 end
 if buttonOver then
  return CButton.buttons[buttonOver]
 else
  return false
 end
end

function CButton.update()
--update angles ---
 if #CButton.buttons > 0 then
  local numButtons = #CButton.buttons
  local segments = 360/numButtons
  for i = 1,360,segments do
   CButton.buttons[((i-1)/segments)+1].angles = {(i-1),(i+segments)-1}
  end
 end
------------------- 
 
end

function CButton.onClick()
 local hover = CButton.getHoverAt(love.mouse.getX(),love.mouse.getY())
 if hover then hover.fn() end
end

function CButton.render()
 if CButton.getState() and #CButton.buttons > 0 then
  local pos = {CButton.getPosition()}
  for k,v in pairs(CButton.buttons) do
   love.graphics.setColor(255,0,0,255)
   love.graphics.arc( "fill", pos[1], pos[2], CButton.radius, math.rad(v.angles[1]), math.rad(v.angles[2]), 16 )
   love.graphics.setColor(0,255,255,255)
   love.graphics.arc( "line", pos[1], pos[2], CButton.radius, math.rad(v.angles[1]), math.rad(v.angles[2]), 16 )
   local hover = CButton.getHoverAt(love.mouse.getX(),love.mouse.getY())
   if hover then
    hover = hover.name
    local textPos = {CButton.getPosition()}
    textPos[1] = textPos[1]-(#hover/2)*7.5
    textPos[2] = textPos[2]+CButton.radius+5
    love.graphics.setColor(255,255,255,255)
    love.graphics.print(hover,textPos[1],textPos[2])
   end
  end
 end
 love.graphics.setColor(255,255,255,255)
end

function CButton.setPosition(x,y)
 CButton.vec2 = {x or CButton.vec2[1],y or CButton.vec2[2]}
end

function CButton.getPosition()
 return CButton.vec2[1],CButton.vec2[2]

end

function CButton.getState()
 return CButton.state
end

function CButton.setState(s)
 CButton.state = s
end































return CButton
