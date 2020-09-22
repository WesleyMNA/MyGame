require("src.model.Aircraft")
require("src.player.PlayerBullet")

Tiger2 = Aircraft:extend("Tiger2")

-- Data set bellow are needed earlier in game
local path = "assets/sprites/player/tiger2/tiger2.png"
Tiger2:setSprite(path)

function Tiger2:new(x, y)
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

function Tiger2:drawTarget()
    local y = self:getY() - FishbedSpecial.range - self.height / 2
    local w, h = self.target:getWidth() / 2, self.target:getHeight() / 2
    love.graphics.draw(self.target, self:getX(), y, 0, 1, 1, w, h)
end
