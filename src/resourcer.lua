local Projectile = require('projectile')
local Vec = require('hump.vector')
local pretty = require("pl.pretty")


local Resourcer = Projectile:subclass('Resourcer')
Resourcer.collision_class = 'Building'
local MAX_RESOURCER_TICK = 30
local MAX_TICK_IN_GENERATIONS = 60
function Resourcer:initialize(gamestate, owner, x, y, launch_params)
    Projectile.initialize(self, gamestate, owner, x, y, 32)
    self.collider:setCollisionClass(Resourcer.collision_class)
    self.lastExpansion = love.timer.getTime()
    self.generation = 1
end
function Resourcer:expandInterval()
    return MAX_RESOURCER_TICK * (math.min(self.generation, MAX_TICK_IN_GENERATIONS) / MAX_TICK_IN_GENERATIONS)
end

function Resourcer:deploy()
    local contacts = self.collider:getContacts('Block')
    for i, contact in ipairs(contacts) do
        local x, y = contact:getPositions()
        if x ~= nil then
            local tilePos = self.gamestate.map:toGridPosVector(Vec(x,y))
            self.gamestate.claims:claimFromResourcer(self, tilePos.x, tilePos.y)
        end
    end
end
function Resourcer:update()
    if self.collider:enter('Block') then
        self:deploy()
    end

end
function Resourcer:draw()
    local cx,cy = self.collider:getPosition()
    love.graphics.setColor(self.owner:getColour())
    love.graphics.circle('fill', cx, cy, self.radius)
end

return Resourcer
