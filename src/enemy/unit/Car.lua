require("src.model.MobileEnemy")
require("src.enemy.EnemyBullet")

Car = MobileEnemy:extend("Car")

function Car:new(x, y, enemyManager)
    local this = {
        speed = 50,
        direction = {
            x = 1,
            y = -1
        }
    }

    setmetatable(this, self)

    local path = "assets/sprites/enemy/car.png"
    this:setSprite(path)

    this:createLandCollider(x, y, this.width / 2)

    this:setEnemyManager(enemyManager)
    this:setBulletClass(EnemyBullet, "atPlayer")
    this:setShotSpeed(1)

    return this
end

function Car:die()
    if self.health <= 0 then
        self.enemyManager:destroyEnemy(self)
        return
    end

    if self:getY() <= 0 then
        self.enemyManager:destroyEnemy(self)
    end
end
