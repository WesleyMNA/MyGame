require('src.model.Aircraft')
require('src.player.PlayerBullet')
require('src.player.fishbed.FishbedSpecial')

Fishbed = Aircraft:extend('Fishbed')

function Fishbed:new(x, y)
    local this = {

        specialTimer = 0.5,
        specialsLaunched = 0,

        scale = {
            x = 1,
            y = 1
        }
    }

    setmetatable(this, self)

    local path = 'assets/sprites/player/fishbed/fishbed.png'
    this:setSprite(path)

    this:createCollider(x, y, 16)

    this:setShotSpeed(0.5)
    this:setBulletClass(PlayerBullet)

    this:setSpecialCooldown(5)

    return this
end

function Fishbed:launchSpecial()
    if self.specialTimer >= 0.5 then
        self.specialTimer = 0

        local side
        if self.specialsLaunched % 2 == 0 then side = 1 else side = -1 end

        local x = self:getX() - 13 * side
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