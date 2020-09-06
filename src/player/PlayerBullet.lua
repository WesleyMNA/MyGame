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
    this.collider:setCategory(PLAYER_CATEGORY.bullet)
    this.collider:setMask(
        PLAYER_CATEGORY.collider,
        PLAYER_CATEGORY.bullet,
        PLAYER_CATEGORY.fallingBomb,
        PLAYER_CATEGORY.bomb
    )

    this.collider:setObject(this)

    return this
end

function PlayerBullet:collide()
    if self:isOutOfScreen() or self:hitEnemy() then self.shooter:destroyBullet(self) end
end

function PlayerBullet:hitEnemy()
    return self.collider:enter('Enemy')
end
