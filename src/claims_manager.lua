local class = require("astray.MiddleClass")
local gridgen = require("gridgen")
local pl_table = require('pl.tablex')
local Claim = require("claim")
local Vec = require('hump.vector')
local Entity = require('entity')

local ClaimsManager = Entity:subclass("ClaimsManager")
function ClaimsManager:initialize(gamestate)
    Entity.initialize(self, gamestate, nil, 'claims_manager') -- has no owner
    self.generation = 0
    self.grid = {}
    for x = 0, gamestate.config.world_width do
        self.grid[x] = {}
        for y = 1, gamestate.config.world_height do
            self.grid[x][y] = false
        end
    end
    gamestate.claims = self
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
function ClaimsManager:manageResourcer(resourcer)
    self.resourcerClaims[resourcer] = {}
    resourcer.cooldown:set(resourcer:expandInterval(), function ()
        self:expandResourcer(resourcer)
    end)
end
function ClaimsManager:addClaim(resourcer, x, y, generation)
    local newClaim = Claim:new(self.gamestate, x, y, resourcer, generation)
    self.grid[x][y] = newClaim
    if not self.resourcerClaims[resourcer] then
        self:manageResourcer(resourcer)
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
    for i, claim in ipairs(claims) do
        if claim.generation < resourcer.generation then
            self:expandClaim(claim)
        end
    end
    resourcer.cooldown:set(resourcer:expandInterval(), function ()
        self:expandResourcer(resourcer)
    end)
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
function ClaimsManager:declaimResourcer(resourcer)
    local claims = self.resourcerClaims[resourcer]
    if claims == nil then
        print('TODO(clara): is it okay that this is null?')
        return
    end
    for i, claim in ipairs(claims) do
        self.grid[claim.x][claim.y] = false
        claim:die()
    end
    self.resourcerClaims[resourcer] = nil
end

function ClaimsManager:refresh(tm, grid)
    tm:_foreachTile(function(x,y)
        if not grid[x][y] and self.grid[x][y] then
            local claim = self.grid[x][y]
            self.grid[x][y] = false
            claim:die()
            local resClaims = self.resourcerClaims[claim.resourcer]
            local idx = pl_table.find(resClaims, claim)
            if idx ~= nil then
                table.remove(resClaims, idx)
            end

        end

    end)
end


function ClaimsManager:update(dt)
    Entity.update(self, dt)
end

function ClaimsManager:draw()
    Entity.draw(self)
    -- nothing to draw
end

return ClaimsManager
