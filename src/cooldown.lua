local class = require("astray.MiddleClass")

local CoolDown = class("CoolDown")

local MAX_RESOURCES = 4000


function CoolDown:initialize(parentBody, offsetX, offsetY, width)
    self.parentBody = parentBody
    self.offsetX = offsetX
    self.offsetY = offsetY
    self.width = width
    self:reset()
end

function CoolDown:reset()
    self.startedAt = nil
    self.nextCallback = nil
    self.endsAt = nil
    self.duration = nil
end

function CoolDown:isActive()
    return not not self.nextCallback
end
function CoolDown:set(duration, callback)
    if self:isActive() then
        print("WARNING: Resetting a cooldown before it completed")
    end
    self.startedAt = love.timer.getTime()
    self.duration = duration
    self.endsAt = self.startedAt + duration
    self.nextCallback = callback
end

function CoolDown:complete()
    local callback = self.nextCallback
    self:reset()
    callback()
end

function CoolDown:update()
    if self:isActive()  and love.timer.getTime() > self.endsAt then
        self:complete()
    end
end

function CoolDown:progress()
    local timeLeft = self.endsAt - love.timer.getTime()
    local timeElapsed = self.duration - timeLeft
    return timeElapsed / self.duration
end


function CoolDown:draw()
    if self.endsAt then
        local px, py = self.parentBody:getPosition()
        local x = px + self.offsetX
        local y = py + self.offsetY
        love.graphics.setLineWidth(5)
        love.graphics.setColor(0, 0,0,0.8)
        love.graphics.line(x, y, x + self:progress() * self.width , y)
    end
end

return CoolDown