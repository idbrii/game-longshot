local class = require("astray.MiddleClass")

local Tech = class("Tech")

local MAX_RESOURCES = 2000

function Tech:initialize(owner)
    self.owner = owner
    self.resources = 0
end

function Tech:addResource(amount)
    self.resources = self.resources + amount
end

function Tech:deductResource(amount)
    self.resources = self.resources - amount
end

function Tech:drawResourceUI()
    local width = 30
    local padding = 10
    local marginTop = 120
    local marginBottom = 300
    local barHeight = love.graphics.getHeight() - marginBottom - marginTop
    local origin = self.owner.index == 1 and padding or (love.graphics.getWidth() - width - padding)
    local r, g, b = self.owner:getColour()
    love.graphics.setColor(r, g, b, 0.5)
    love.graphics.setLineWidth(2)
    love.graphics.rectangle('line', origin, marginTop, width, barHeight)

    local resourceBarHeight = (math.min(self.resources, MAX_RESOURCES) / MAX_RESOURCES) * barHeight
    local emptySpaceHeight = barHeight - resourceBarHeight
    love.graphics.rectangle('fill', origin, marginTop + emptySpaceHeight, width, resourceBarHeight)

end

return Tech