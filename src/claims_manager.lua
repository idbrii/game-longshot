local class = require("astray.MiddleClass")
local gridgen = require("gridgen")
local Claim = require("claim")
local Vec = require('hump.vector')

local ClaimsManager = class("ClaimsManager")
function ClaimsManager:initialize(gamestate)
    self.gamestate = gamestate
    self.generation = 0
    self.grid = {}
    for x = 0, gamestate.config.world_width do
        self.grid[x] = {}
        for y = 1, gamestate.config.world_height do
            self.grid[x][y] = false
        end
    end
    gamestate.claims = self
    table.insert(gamestate.entities, self)
    self.resourcerClaims = {}
end

function ClaimsManager:isUnclaimed(x, y)
    if x > table.getn(self.grid) or x < 0 then
        return false
    end
    if y > table.getn(self.grid[x]) or y < 0 then
        return false
    end
    return self.gamestate.grid[x][y] and not self.grid[x][y]
end

function ClaimsManager:addClaim(resourcer, x, y, generation)
    local newClaim = Claim:new(self.gamestate, x, y, resourcer, generation)
    self.grid[x][y] = newClaim
    if not self.resourcerClaims[resourcer] then
        self.resourcerClaims[resourcer] = {}
    end
    table.insert(self.resourcerClaims[resourcer], newClaim)
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

function ClaimsManager:expandResourcer(resourcer)
    local claims = self.resourcerClaims[resourcer]
    resourcer.generation = resourcer.generation + 1
    print(resourcer:expandInterval())
    for i, claim in ipairs(claims) do
        if claim.generation < resourcer.generation then
            self:expandClaim(claim)
        end
    end
end

function ClaimsManager:expandClaim(claim)
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
    --for resourcer, claims in pairs(self.resourcerClaims) do
    for resourcer in pairs(self.resourcerClaims) do
        if ts > (resourcer.lastExpansion + resourcer:expandInterval()) then
            self:expandResourcer(resourcer)
            resourcer.lastExpansion = ts
        end
    end


end

function ClaimsManager:draw()
    -- nothing to draw
end

return ClaimsManager