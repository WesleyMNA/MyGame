require('src.model.Bullet')

EnemyBullet = Bullet:extend('EnemyBullet')

function EnemyBullet:new(x, y, shooter)
    local this = {
        scale = {
            x = 1,
            y = -1
        },

        direction = {}
    }

    setmetatable(this, self)

    this:setEnemyManager(shooter.enemyManager)

    local path = 'assets/sprites/player/bullet.png'
    this:setSprite(path)

    this:createCollider(x, y)
    this.collider:setCollisionClass('EnemyBullet')
    this.collider:setCategory(ENEMY_CATEGORY.bullet)
    this.collider:setMask(
        ENEMY_CATEGORY.airCollider,
        ENEMY_CATEGORY.landCollider,
        ENEMY_CATEGORY.bullet,
        PLAYER_CATEGORY.bullet,
        PLAYER_CATEGORY.fallingBomb,
        PLAYER_CATEGORY.bomb
    )

    this.collider:setObject(this)

    this:getDirection()

    return this
end

function EnemyBullet:move(dt)
    local x = self.collider:getX() + dt * self.direction.x * self.speed
    local y = self.collider:getY() + dt * self.direction.y * self.speed
    self.collider:setX(x)
    self.collider:setY(y)
end

function EnemyBullet:collide()
    if self:isOutOfScreen() or self:hitPlayer() then self.enemyManager:destroyObject(self) end
end

function EnemyBullet:hitPlayer()
    return self.collider:enter('Player')
end

function EnemyBullet:getDirection()
    local player = self.enemyManager.player

    local side = {}
    side.x = player:getX() - self:getX()
    side.y = player:getY() - self:getY()
    local hypotenuse = math.sqrt(side.x^2 + side.y^2)

    self.direction.x = side.x/hypotenuse
    self.direction.y = side.y/hypotenuse
end
