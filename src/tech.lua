local class = require("astray.MiddleClass")
local screener = require('screener')

local Tech = class("Tech")

local MAX_RESOURCES = 4000/2

Tech.font = love.graphics.newFont("assets/pixelart/font/humblefree/futile.ttf", 19)

Tech.Effects = {
    Basic = {
        name="Basic",
        resourceCost = 0,
        restitution = 0.2,
        input_name = "mod_normal",
    },
    Bouncy = {
        name="Bouncy",
        resourceCost = 700/2,
        restitution = 0.6,
        input_name = "mod_bouncy",
    },
    Boosty = {
        name="Boosty",
        resourceCost = 1500/2,
        restitution = 0.1,
        input_name = "mod_boosty",
    },
    Sticky = {
        name="Sticky",
        resourceCost = 2500/2,
        restitution = 0.1,
        input_name = "mod_sticky",
    }
}

function Tech:initialize(owner)
    self.owner = owner
    self.techLevels = {
        Tech.Effects.Basic,
        Tech.Effects.Bouncy,
        Tech.Effects.Boosty,
        Tech.Effects.Sticky,
    }
    self.resources = 0
    self.selectedEffect = Tech.Effects.Basic
end

function Tech:selectEffect(effect)
    if effect.resourceCost < self.resources then
        self.selectedEffect = effect
    end
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

function Tech:drawResourceUI(input_mapping)
    local height = 20
    local padding = 5
    local gutter = 64 + padding * 2
    local screenWidth,screenHeight = screener.getDimensions()
    local width = screenWidth / 2 - padding - gutter
    local top = screenHeight - padding - height
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
        love.graphics.setColor(0.5, 0.5, 0.5)
        if level.resourceCost < self.resources then
            love.graphics.setColor(0, 0, 0)
        end
        local key_hint = input_mapping[level.input_name]
        key_hint = " (" .. key_hint .. ")"
        if self.selectedEffect == level then
            love.graphics.setColor(0, 0.5, 0.5)
            key_hint = ''
        end
        local markerX = left + (level.resourceCost / MAX_RESOURCES) * width
        local markerY = top - 20
        love.graphics.line(markerX, markerY, markerX, top + height)
        local str = level.name .. key_hint
        love.graphics.printf(str, self.font, markerX + padding, markerY, 2000)

    end

end

return Tech
