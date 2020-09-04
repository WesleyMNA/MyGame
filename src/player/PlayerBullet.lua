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
    this.collider:setCategory(PLAYER_CATEGORY.bullet)
    this.collider:setMask(PLAYER_CATEGORY.collider)

    this.collider:setObject(this)
    
    return this
end

function PlayerBullet:collide()
    if self:getY() <= 0 or self:hitEnemy() then self.aircraft:destroyBullet(self) end
end

function PlayerBullet:hitEnemy()
    return self.collider:enter('Enemy')
end
