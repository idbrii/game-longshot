local Entity = require('entity')
local Damagable = require "damagable"
local M = require("moses.moses")
local Projectile = require('projectile')
local Vec = require('hump.vector')
local Vfx = require('vfx')
local tuning = require('tuning')

local Bomb = Entity:subclass('Bomb')

Bomb.launchCoolDown = tuning.cool_downs.bomb

function Bomb:initialize(gamestate, owner, x, y, launch_params)
    Entity.initialize(self, gamestate, owner, 'bomb')
    self.techEffect = launch_params.techEffect
    self.projectile = Projectile:new(self, owner, x, y, tuning.size.radius.bomb, gamestate.art.bomb, launch_params.techEffect, false)
    self.projectile.triggerdeath_cb = function()
        self:die()
    end
    self:setCollider(self.projectile.collider)

    self.tint = 1
    table.insert(self.projectile.onWallActivate_cb, function(_, ...)
        self:onHitSomething(...)
    end)
    table.insert(self.projectile.onHitBuilding_cb, function(_, ...)
        self:onHitSomething(...)
    end)
end

function Bomb:update(dt)
    self.projectile:update(dt)
end
function Bomb:draw()
    self.projectile:draw()
end


function Bomb:die()
    Entity.die(self)
    self.projectile:die()
end

function Bomb:onHitSomething(collision_data)
    -- ignore Projectile behavior
    self:_explode()
end

local function tryDestroyTile(grid, x, y)
    if grid[x] and grid[x][y] then
        grid[x][y] = false
    end
end

function Bomb:_getBlastRadiusEntities()
    -- queryCircleArea and sensors don't work. Just brute force it.
    local pos = Vec(self.collider:getPosition())
    local rad2 = tuning.size.bomb.blast_radius * tuning.size.bomb.blast_radius
    local victims = {}
    for i,ent in ipairs(self.gamestate.entities) do
        if ent.collider and ent.damagable and ent ~= self then
            local victim_pos = Vec(ent.collider:getPosition())
            if pos:dist2(victim_pos) < rad2 then
                table.insert(victims, ent)
            end
        end
    end
    return victims
end

function Bomb:_explode()
    for i,ent in ipairs(self:_getBlastRadiusEntities()) do
        ent.damagable:takeDamage(tuning.damage_dealer.bomb)
    end
    local screen_pos = Vec(self.collider:getPosition())
    local grid_pos = self.gamestate.map:toGridPosVector(screen_pos)
    local grid = self.gamestate.grid

    local x,y = grid_pos.x,grid_pos.y
    local radius = math.ceil(tuning.size.bomb.blast_radius / self.gamestate.config.tile_size)
    local function apply_destruction(fn)
        for it_x=x-radius,x+radius do
            for it_y=y-radius,y+radius do
                local is_corner = (it_x == x-radius or it_x == x+radius) and (it_y == y-radius or it_y == y+radius)
                if not is_corner then
                    fn(it_x, it_y)
                end
            end
        end
    end

    apply_destruction(function(...)
        tryDestroyTile(grid, ...)
    end)

    -- Draw removed tiles
    --~ self.gamestate.debug_draw_fn = function()
    --~     apply_destruction(function(it_x, it_y)
    --~         local hsize = self.gamestate.config.tile_size / 2
    --~         local draw_x = it_x*self.gamestate.config.tile_size + hsize
    --~         local draw_y = it_y*self.gamestate.config.tile_size + hsize
    --~         love.graphics.circle('fill', draw_x, draw_y, 3)
    --~     end)
    --~ end

    self.gamestate.map:refresh(grid)
    self:die()
    Vfx:new(self.gamestate, screen_pos.x, screen_pos.y, 'explosion', {
            fade_seconds = .7,
        })
end

return Bomb
