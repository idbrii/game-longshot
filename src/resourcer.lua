local class = require("astray.MiddleClass")
local Vec = require('hump.vector')
local pretty = require("pl.pretty")


local Resourcer = class("Resourcer")
Resourcer.collision_class = 'Building'
function Resourcer:initialize(gamestate, x, y, player)
    self.gamestate = gamestate
    self.radius = 32
    self.collider = gamestate.world:newCircleCollider(x, y, self.radius)
    self.owner = player
    self.collider:setCollisionClass(Resourcer.collision_class)
    table.insert(gamestate.entities, self)
end
function Resourcer:addClaimFrom(x, y)

end
function Resourcer:addClaimAt(x, y)
    Claim:new(self.gamestate, x, y, self)
end
function Resourcer:deploy()
    self.collider:setAwake(false)
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