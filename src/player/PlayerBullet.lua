require('src.model.Bullet')

PlayerBullet = Bullet:extend('PlayerBullet')

function PlayerBullet:new(x, y, shooter)
    local this = {
        scale = {
            x = 1,
            y = -1
        }
    }

    setmetatable(this, self)

    this:setShooter(shooter)

    local path = 'assets/sprites/player/bullet.png'
    this:setSprite(path)

    this:createCollider(x, y)
    this.collider:setCollisionClass('PlayerBullet')
    this.collider:setMask(PLAYER_CATEGORY.collider)

    return this
end

function PlayerBullet:collide()
    if self:getY() <= 0 then self.shooter:destroyBullet(self) end
end
