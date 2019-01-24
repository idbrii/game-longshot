local class = require("astray.MiddleClass")

local Tech = class("Tech")

local MAX_RESOURCES = 4000

Tech.Levels = {
    Bouncy = {
        name="Bouncy",
        key= {'f1', '?1'},
        resourceCost = 700,
    },
    Boosty = {
        name="Boosty",
        key= {'f2', '?2'},
        resourceCost = 1500,
    },
    Sticky = {
        name="Sticky",
        key= {'f3', '?3'},
        resourceCost = 2500,
    }
}

function Tech:initialize(owner)
    self.owner = owner
    self.techLevels = {
        Tech.Levels.Bouncy,
        Tech.Levels.Boosty,
        Tech.Levels.Sticky,
    }
    self.techLevel = nil
    self.resources = 0
end

function Tech:getTechLevel()
    for i, level in ipairs(self.techLevels) do
        if (self.resources >= level.resourceCost) then
            return level
        end
    end
end

function Tech:addResource(amount)
    self.resources = self.resources + amount
    self.techLevel = self:getTechLevel()
end

function Tech:deductResource(amount)
    self.resources = self.resources - amount
    self.techLevel = self:getTechLevel()
end

function Tech:drawResourceUI()
    local width = 30
    local padding = 10
    local marginTop = 120
    local marginBottom = 300
    local barHeight = love.graphics.getHeight() - marginBottom - marginTop
    local origin = self.owner.index == 1 and padding or (love.graphics.getWidth() - width - padding)
    local r, g, b = self.owner:getColour()

    -- Tech progress bar
    love.graphics.setColor(r, g, b, 0.5)
    love.graphics.setLineWidth(2)
    love.graphics.rectangle('line', origin, marginTop, width, barHeight)

    -- Tech progress fill
    local resourceBarHeight = (math.min(self.resources, MAX_RESOURCES) / MAX_RESOURCES) * barHeight
    local emptySpaceHeight = barHeight - resourceBarHeight
    love.graphics.rectangle('fill', origin, marginTop + emptySpaceHeight, width, resourceBarHeight)


    -- Tech level... levels

    for i, level in ipairs(self.techLevels) do
        love.graphics.setColor(255, 255, 255)
        if level == self.techLevel then
            love.graphics.setColor(0, 0, 255)
        end
        local textWidth = 75
        local x1 = self.owner.index == 1 and origin or origin - textWidth
        local x2 = origin + width + textWidth
        local textX = self.owner.index ==1 and x1 + width + 5 or x1
        local distanceFromBottom = (level.resourceCost / MAX_RESOURCES) * barHeight
        local y = marginTop + (barHeight - distanceFromBottom)
        love.graphics.line(x1, y, x2, y)
        love.graphics.print(level.name .. " (" .. level.key[self.owner.index] .. ")",  textX, y)

    end
    
end

return Tech