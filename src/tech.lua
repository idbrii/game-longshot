local class = require("astray.MiddleClass")

local Tech = class("Tech")

local MAX_RESOURCES = 4000

Tech.Levels = {
    --~ Normal = {
    --~     name="Normal",
    --~     key= {'1', '7'},
    --~     resourceCost = 0,
    --~ },
    Bouncy = {
        name="Bouncy",
        key= {'2', '8'},
        resourceCost = 700,
    },
    Boosty = {
        name="Boosty",
        key= {'3', '9'},
        resourceCost = 1500,
    },
    Sticky = {
        name="Sticky",
        key= {'4', '0'},
        resourceCost = 2500,
    }
}

function Tech:initialize(owner)
    self.owner = owner
    self.techLevels = {
        --~ Tech.Levels.Normal,
        Tech.Levels.Bouncy,
        Tech.Levels.Boosty,
        Tech.Levels.Sticky,
    }
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
end

function Tech:deductResource(amount)
    self.resources = self.resources - amount
end

function Tech:drawResourceUI()
    local height = 20
    local padding = 5
    local gutter = 64 + padding * 2
    local screenWidth = love.graphics.getWidth()
    local width = screenWidth / 2 - padding - gutter
    local top = love.graphics.getHeight() - padding - height
    local left = self.owner.index == 1 and gutter or (screenWidth / 2 + padding)
    local r, g, b = self.owner:getColour()

     --Tech progress bar
    love.graphics.setColor(r, g, b, 0.5)
    love.graphics.setLineWidth(2)
    love.graphics.rectangle('line', left, top, width, height)

    ---- Tech progress fill
    local resourceBarWidth = (math.min(self.resources, MAX_RESOURCES) / MAX_RESOURCES) * width

    love.graphics.rectangle('fill', left, top, resourceBarWidth, height)


    -- Tech level... levels

    for i, level in ipairs(self.techLevels) do
        love.graphics.setColor(0, 0, 0)
        if level.resourceCost < self.resources then
            love.graphics.setColor(0, 0, 1)
        end
        local textWidth = 75
        local markerX = left + (level.resourceCost / MAX_RESOURCES) * width
        local markerY = top - 20
        love.graphics.line(markerX, markerY, markerX, top + height)
        love.graphics.print(level.name .. " (" .. level.key[self.owner.index] .. ")",  markerX + padding, markerY)

    end

end

return Tech
