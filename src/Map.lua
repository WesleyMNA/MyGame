require('src.player.fishbed.Fishbed')
require('src.enemy.EnemyManager')

require('src.Tile')

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
    bullet = 12
}

-- Tiles
TILE_EMPTY = 1
SAND = 3
DARK_SAND = 4

Map = {}
Map.__index = Map

function Map:new()
    local this = {
        class = 'Map',

        x = 0,
        y = 0,
        initialPoint = -5,

        width = math.ceil(WINDOW_WIDTH/TILE_SIZE),
        height = math.ceil(WINDOW_HEIGHT/TILE_SIZE),

        player = Fishbed:new(150, 450),

        tiles = {},
        scale = 25,
    }

    this.enemyManager = EnemyManager:new(this)

    setmetatable(this, self)

    for y = this.initialPoint, this.height do
        for x = 0, this.width do
            local n = love.math.noise(x/this.scale, y/this.scale)
            if n <= 0.5 then tile = SAND else tile = DARK_SAND end
            this:addTile(x, y, tile)
        end
    end

    return this
end

function Map:update(dt)
    self.y = self.y + 1
    if self.y % 16 == 0 then self:createNewLayer() end
    updateLoop(dt, self.tiles)
    self.player:update(dt)
    self.enemyManager:update(dt)
end

function Map:render()
    setColor(WHITE)

    renderLoop(self.tiles)

    self.enemyManager:render()
    self.player:render()

    lovePrint('Tiles in scene: '.. #self.tiles, 0, 60)
end

function Map:createNewLayer()
    local tile
    for x=0, self.width do
        local n = love.math.noise(x/self.scale, self.y/self.scale)
        if n <= 0.5 then tile = SAND else tile = DARK_SAND end
        self:addTile(x, self.initialPoint, tile)
    end
end

function Map:addTile(x, y, n)
    x, y = x * TILE_SIZE, y * TILE_SIZE
    local tile = Tile:new(x, y, n)
    table.insert(self.tiles, tile)
end

function Map:destroyTile(tile)
    local index = table.indexOf(self.tiles, tile)
    table.remove(self.tiles, index)
    if tile.collider then tile.collider:destroy() end
end

function Map:getTile(x, y)
    return self.tiles[(y - 1) * self.width + x]
end
