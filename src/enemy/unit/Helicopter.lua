require('src.model.MobileEnemy')
require('src.enemy.EnemyBullet')

Helicopter = MobileEnemy:extend('Helicopter')

function Helicopter:new(x, y, enemyManager)
    local this = {}

    setmetatable(this, self)

    local path = 'assets/sprites/enemy/helicopter.png'
    this:setSprite(path)
    this.width, this.height = this.sprite:getHeight(), this.sprite:getHeight()
    this:createAnimation()

    this:createAirCollider(x, y, this.width/2)

    this:setEnemyManager(enemyManager)
    this:setBulletClass(EnemyBullet, 'atPlayer')
    this:setShotSpeed(1)

    return this
end

function Helicopter:render()
    love.graphics.draw(
        self.sprite, self.quad,
        self:getX(), self:getY(),
        0, self.scale.x, self.scale.y,
        self.width/2, self.height/2
    )
end

function Helicopter:createAnimation()
    self.quad = love.graphics.newQuad(0, 0, self.width, self.height, self.sprite:getDimensions())
    local animationData = {
        fps = 20,
        frames = 2,
        xoffsetMul = self.width,
        yoffset = 0,
        loop = true
    }
    self.animation = Animation:new(self.quad, animationData)
end
