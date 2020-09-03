require('src.model.Bullet')

PlayerBullet = Bullet:extend('PlayerBullet')

function PlayerBullet:new(x, y, aircraft)
    local this = {
        scale = {
            x = 1,
            y = -1
        }
    }

    setmetatable(this, self)

    this:setAircraft(aircraft)

    local path = 'assets/sprites/player/bullet.png'
    this:setSprite(path)

    this:createCollider(x, y)
    this.collider:setCollisionClass('PlayerBullet')
    this.collider:setMask(PLAYER_CATEGORY.collider)

    return this
end

function PlayerBullet:collide()
    if self:getY() <= 0 then self.aircraft:destroyBullet(self) end
end
