require('src.model.MobileEnemy')
require('src.enemy.EnemyBullet')

Tank = MobileEnemy:extend('Tank')

function Tank:new(x, y, enemyManager)
    local this = {
        speed = 60
    }

    setmetatable(this, self)

    local path = 'assets/sprites/enemy/tank/body.png'
    this:setSprite(path)

    this.cannon = love.graphics.newImage('assets/sprites/enemy/tank/cannon.png')

    this:createLandCollider(x, y, this.width/2)

    this:setEnemyManager(enemyManager)
    this:setBulletClass(EnemyBullet, 'atPlayer')
    this:setShotSpeed(1)

    return this
end

function getInt(n)
    if n < 0 then
        return math.floor(n)
    else
        return math.ceil(n)
    end
end

function Tank:render()
    local dx, dy = self:getDirection()
    local r = -dx * dy
    dy = getInt(dy)

    love.graphics.draw(
        self.sprite, self:getX(), self:getY(),
        0, self.scale.x, self.scale.y,
        self.width/2, self.height/2
    )

    love.graphics.draw(
        self.cannon, self:getX(), self:getY(),
        r, self.scale.x, dy,
        self.width/2, self.height/2
    )
end

function Tank:getDirection()
    local player = self.enemyManager.player

    local side = {}
    side.x = player:getX() - self:getX()
    side.y = player:getY() - self:getY()
    local hypotenuse = math.sqrt(side.x^2 + side.y^2)

    return side.x/hypotenuse, side.y/hypotenuse
end