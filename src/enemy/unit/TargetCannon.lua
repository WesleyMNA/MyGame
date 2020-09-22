require("src.model.MobileEnemy")
require("src.enemy.EnemyBullet")

TargetCannon = MobileEnemy:extend("TargetCannon")

function TargetCannon:new(x, y, enemyManager)
    local this = {
        speed = 60
    }

    setmetatable(this, self)

    local path = "assets/sprites/enemy/target-cannon.png"
    this:setSprite(path)

    this:createLandCollider(x, y, this.width / 2)

    this:setEnemyManager(enemyManager)
    this:setBulletClass(EnemyBullet, "atPlayer")
    this:setShotSpeed(1)

    return this
end

function TargetCannon:render()
    love.graphics.draw(
        self.sprite,
        self:getX(),
        self:getY(),
        0,
        self.scale.x,
        self.scale.y,
        self.width / 2,
        self.height / 2
    )
end
