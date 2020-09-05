require('src.model.Bullet')

EnemyBullet = Bullet:extend('EnemyBullet')

function EnemyBullet:new(x, y, shooter)
    local this = {
        scale = {
            x = 1,
            y = -1
        },

        target = {}
    }
    
    setmetatable(this, self)

    this:setShooter(shooter)

    local path = 'assets/sprites/player/bullet.png'
    this:setSprite(path)

    this:createCollider(x, y)
    this.collider:setCollisionClass('EnemyBullet')
    this.collider:setCategory(ENEMY_CATEGORY.bullet)
    this.collider:setMask(ENEMY_CATEGORY.airCollider)
    this.collider:setMask(ENEMY_CATEGORY.landCollider)

    this.collider:setObject(this)
    
    return this
end

function EnemyBullet:move(dt)

end

function EnemyBullet:collide()
    -- if self:getY() <= 0 or self:hitPlayer() then self.shooter:destroyBullet(self) end
end

function EnemyBullet:hitPlayer()
    return self.collider:enter('Player')
end
