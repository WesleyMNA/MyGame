require("src.model.Aircraft")
require("src.player.PlayerBullet")
require("src.player.fishbed.FishbedSpecial")

Fishbed = Aircraft:extend("Fishbed")

-- Data set bellow are needed earlier in game
local path = "assets/sprites/player/fishbed/fishbed.png"
Fishbed:setSprite(path)

function Fishbed:new(x, y)
    local this = {
        launchBombs = true,
        target = love.graphics.newImage("assets/sprites/player/target.png"),
        specialTimer = 0.5,
        specialsLaunched = 0,
        scale = {
            x = 1,
            y = 1
        }
    }

    setmetatable(this, self)

    this:createCollider(x, y, this.height / 2)

    this:setShotSpeed(0.5)
    this:setBulletClass(PlayerBullet)

    this:setSpecialCooldown(5)

    return this
end

function Fishbed:launchSpecial()
    if self.specialTimer >= 0.2 then
        self.specialTimer = 0

        local side
        if self.specialsLaunched % 2 == 0 then
            side = 1
        else
            side = -1
        end

        local x = self:getX() - 17 * side
        local y = self:getY() - 6
        local special = FishbedSpecial:new(x, y, self)
        table.insert(self.specials, special)
        self.specialsLaunched = self.specialsLaunched + 1

        if self.specialsLaunched >= 6 then
            self.specialsLaunched = 0
            self.enableSpecial = false
        end
    end
end

function Fishbed:drawTarget()
    local y = self:getY() - FishbedSpecial.range - self.height / 2
    local w, h = self.target:getWidth() / 2, self.target:getHeight() / 2
    love.graphics.draw(self.target, self:getX(), y, 0, 1, 1, w, h)
end
