require("src.Tile")
require("src.manager.EnemyManager")
require("src.player.fishbed.Fishbed")
require("src.player.tiger2.Tiger2")
require("src.gui.controller.Controller")


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
        class = "Map",
        x = 0,
        y = 0,
        initialPoint = -5,
        width = math.ceil(WINDOW_WIDTH / TILE_SIZE),
        height = math.ceil(WINDOW_HEIGHT / TILE_SIZE),
        tiles = {},
        scale = 25
    }

    local aircraft = AIRCRAFTS_MANAGER:getCurrentAircraft()
    this.player = aircraft:new(150, 450)
    this.controller = Controller:new(this)
    this.enemyManager = EnemyManager:new(this)

    setmetatable(this, self)

    for y = this.initialPoint, this.height do
        for x = 0, this.width do
            local n = love.math.noise(x / this.scale, y / this.scale)
            if n <= 0.5 then
                tile = SAND
            else
                tile = DARK_SAND
            end
            this:addTile(x, y, tile, this)
        end
    end

    return this
end

function Map:update(dt)
    self.y = self.y + 1
    if self.y % 16 == 0 then
        self:createNewLayer()
    end
    updateLoop(dt, self.tiles)
    self.controller:update(dt)
    self.player:update(dt)
    self.enemyManager:update(dt)
    WORLD:update(dt)
end

function Map:render()
    setColor(WHITE)

    renderLoop(self.tiles)

    self.enemyManager:render()
    self.player:render()
    self.controller:render()
    -- WORLD:draw(0.5)
end

function Map:createNewLayer()
    local tileType
    for x = 0, self.width do
        local n = love.math.noise(x / self.scale, self.y / self.scale)
        if n <= 0.5 then
            tileType = SAND
        else
            tileType = DARK_SAND
        end
        self:addTile(x, self.initialPoint, tileType)
    end
end

function Map:addTile(x, y, tileType)
    x, y = x * TILE_SIZE, y * TILE_SIZE
    local tile = Tile:new(x, y, tileType, self)
    table.insert(self.tiles, tile)
end

function Map:destroyTile(tile)
    local index = table.indexOf(self.tiles, tile)
    table.remove(self.tiles, index)
    if tile.collider then
        tile.collider:destroy()
    end
end

function Map:getTile(x, y)
    return self.tiles[(y - 1) * self.width + x]
end
