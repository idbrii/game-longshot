local class = require("astray.MiddleClass")
local gridgen = require("gridgen")
local Claim = require("claim")
local Vec = require('hump.vector')
-- @todo make per resourcer!
local tmpGen = 1
local ClaimsManager = class("ClaimsManager")
function ClaimsManager:initialize(gamestate)
    self.expandInterval = 1.5
    self.lastExpansion = love.timer.getTime()
    self.gamestate = gamestate
    self.grid = {}
    for x = 1, gamestate.config.world_width do
        self.grid[x] = {}
        for y = 1, gamestate.config.world_height do
            self.grid[x][y] = false
        end
    end
    gamestate.claims = self
    table.insert(gamestate.entities, self)
    self.claims = {}
end

function ClaimsManager:isUnclaimed(x, y)
    if x > table.getn(self.grid) then
        return false
    end
    if y > table.getn(self.grid[x]) then
        return false
    end
    return self.gamestate.grid[x][y] and not self.grid[x][y]
end

function ClaimsManager:addClaim(resourcer, x, y, generation)
    local newClaim = Claim:new(self.gamestate, x, y, resourcer, generation)
    self.grid[x][y] = newClaim
    table.insert(self.claims, newClaim)
    return newClaim
end

function ClaimsManager:claimFromResourcer(resourcer, x, y)
    if self:isUnclaimed(x, y) then
        self:addClaim(resourcer, x, y, 1)
    else
        local directions = {
            Vec(x - 1, y),
            Vec(x + 1, y),
            Vec(x, y - 1),
            Vec(x, y + 1),
        }
        for i, vec in ipairs(directions) do
            if self:isUnclaimed(vec.x, vec.y) then
                self:addClaim(resourcer, vec.x, vec.y, 1)
            end
        end
    end
end

function ClaimsManager:expandAll()
    tmpGen = tmpGen + 1
    for i, claim in ipairs(self.claims) do
        if claim.generation < tmpGen then
            self:expand(claim)
        end

    end

end

function ClaimsManager:expand(claim)
    local directions = {
        Vec(claim.x - 1, claim.y),
        Vec(claim.x + 1, claim.y),
        Vec(claim.x, claim.y - 1),
        Vec(claim.x, claim.y + 1),
    }
    for i, vec in ipairs(directions) do
        if self:isUnclaimed(vec.x, vec.y) then
            self:addClaim(claim.resourcer, vec.x, vec.y, claim.generation + 1)
        end
    end
end

function ClaimsManager:update()
    local ts = love.timer.getTime()
    if ts > (self.lastExpansion + self.expandInterval) then
        self:expandAll()
        self.lastExpansion = ts
    end
end

function ClaimsManager:draw()
    -- nothing to draw
end

return ClaimsManager