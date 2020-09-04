require('src.player.fishbed.Fishbed')
require('src.enemy.EnemyManager')

PLAYER_CATEGORY = {
    collider = 1,
    bullet = 2,
    missile = 3,
    bomb = 4,
    fallingBomb = 5
}

ENEMY_CATEGORY = {
    airCollider = 10,
    landCollider = 11,
}


Map = {}
Map.__index = Map

function Map:new()
    local this = {
        class = 'Map',

        player = Fishbed:new(150, 450),
        enemyManager = EnemyManager:new()
    }

    this.sprite = love.graphics.newImage('assets/sprites/map.png')
    setmetatable(this, self)
    return this
end

function Map:update(dt)
    self.player:update(dt)
    self.enemyManager:update(dt)
end

function Map:render()
    setColor(WHITE)
    love.graphics.draw(self.sprite)
    self.player:render()
    self.enemyManager:render()
end
