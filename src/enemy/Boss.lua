require('src.model.MobileEnemy')
require('src.enemy.EnemyBullet')

Boss = MobileEnemy:extend('Boss')

function Boss:new(x, y, enemyManager)
    local this = {
        speed = 50,
        health = 500
    }

    setmetatable(this, self)

    local path = 'assets/sprites/enemy/boss.png'
    this:setSprite(path)

    this:createLandCollider(x, y, this.width/2)
    this.collider:setMass(10000000000000)

    this:setEnemyManager(enemyManager)
    this:setBulletClass(EnemyBullet, 'atPlayer')
    this:setShotSpeed(1)

    return this
end

function Boss:update(dt)
    -- Some enemies have animations to update
    if self.animation then self.animation:update(dt) end

    if self:getY() >= 50 then
        self.speed = 0
    end
    self:move()
    self:collide()
    self:attack()
    self:resetTimer(dt)
    self:die()
end

function Boss:render()
    local p = 'X: '.. math.ceil(self:getX()) ..' Y: '.. math.ceil(self:getY())
    lovePrint(p, self:getX(), self:getY()+50)
    lovePrint(self.health, self:getX(), self:getY()+70)
    love.graphics.draw(
        self.sprite, self:getX(), self:getY(),
        0, self.scale.x, self.scale.y,
        self.width/2, self.height/2
    )
end