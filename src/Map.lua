require('src.player.Fishbed')
require('src.enemy.EnemyManager')

PLAYER_CATEGORY = {
    collider = 1,
}

Map = {}
Map.__index = Map

function Map:new()
    local this = {
        class = 'Map',

        player = Fishbed:new(150, 450),
        enemyManager = EnemyManager:new()
    }

    setmetatable(this, self)
    return this
end

function Map:update(dt)
    self.player:update(dt)
    self.enemyManager:update(dt)
end

function Map:render()
    love.graphics.setColor(WHITE)
    self.player:render()
    self.enemyManager:render()
end
