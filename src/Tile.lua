require("src.util.Util")

local spritesheet = love.graphics.newImage("assets/sprites/tiles.png")
local tileSprites = generateQuads(spritesheet, TILE_SIZE, TILE_SIZE)

Tile = {}
Tile.__index = Tile

function Tile:new(x, y, tile)
    local this = {
        class = "Tile",
        x = x,
        y = y,
        tile = tile
    }

    setmetatable(this, self)
    return this
end

function Tile:update(dt)
    self.y = self.y + 1

    if self.y >= WINDOW_HEIGHT then
        MAP:destroyTile(self)
    end
end

function Tile:render()
    love.graphics.draw(spritesheet, tileSprites[self.tile], self.x, self.y)
end
