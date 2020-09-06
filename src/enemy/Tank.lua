require('src.model.MobileEnemy')
require('src.enemy.EnemyBullet')

Tank = MobileEnemy:extend('Tank')

function Tank:new(x, y, enemyManager)
    local this = {}

    setmetatable(this, self)

    local path = 'assets/sprites/enemy/tank.png'
    this:setSprite(path)

    this:createLandCollider(x, y, 16)

    this:setEnemyManager(enemyManager)
    this:setBulletClass(EnemyBullet)
    this:setShotSpeed(1)

    return this
end
