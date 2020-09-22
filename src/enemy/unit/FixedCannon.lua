require("src.model.MobileEnemy")
require("src.enemy.EnemyBullet")

FixedCannon = MobileEnemy:extend("FixedCannon")

function FixedCannon:new(x, y, enemyManager)
    local this = {
        speed = 60
    }

    setmetatable(this, self)

    local path = "assets/sprites/enemy/fixed-cannon.png"
    this:setSprite(path)

    this:createLandCollider(x, y, this.width / 2)

    this:setEnemyManager(enemyManager)
    this.bulletClass = function()
        -- It fires two bullets at once
        local x = this:getX() + 6
        local y = this:getY()
        local bullet1 = EnemyBullet:new(x, y, this, "straight")
        x = this:getX() - 6
        local bullet2 = EnemyBullet:new(x, y, this, "straight")
        return bullet1, bullet2
    end
    this:setShotSpeed(1)

    return this
end

function FixedCannon:attack()
    if self.shootTimer >= self.shootSpeed then
        self.shootTimer = 0
        local bullet1, bullet2 = self.bulletClass()
        self.enemyManager:addObject(bullet1)
        self.enemyManager:addObject(bullet2)
    end
end
