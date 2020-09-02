require('src.model.Aircraft')
require('src.player.PlayerBullet')

Fishbed = Aircraft:extend('Fishbed')

function Fishbed:new(x, y)
    local this = {
        scale = {
            x = 1,
            y = 1
        }
    }

    setmetatable(this, self)

    local path = 'assets/sprites/player/fishbed.png'
    this:setSprite(path)

    this:createCollider(x, y, 16)

    this:setShotSpeed(0.5)

    this:setBulletClass(PlayerBullet)

    return this
end
