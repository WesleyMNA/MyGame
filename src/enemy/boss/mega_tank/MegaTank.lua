require("src.model.Boss")
require("src.enemy.EnemyBullet")
require("src.enemy.boss.mega_tank.MegaBullet")

MegaTank = Boss:extend("MegaTank")

function MegaTank:new(x, y, enemyManager)
    local this = {
        health = 100,
        megaAttackSpeed = 1
    }

    this.megaAttackTimer = this.megaAttackSpeed

    setmetatable(this, self)

    local path = "assets/sprites/enemy/boss/mega_tank.png"
    this:setSprite(path)

    x = x - this.width / 2
    this:createLandCollider(x, y, this.width, this.height)

    this:setEnemyManager(enemyManager)
    this:setShotSpeed(0.5)

    this.cannons = {
        {
            x = this:getX() - 80,
            y = function()
                return this:getY() + 25
            end
        },
        {
            x = this:getX() - 63,
            y = function()
                return this:getY() - 25
            end
        },
        {
            x = this:getX() + 80,
            y = function()
                return this:getY() + 25
            end
        },
        {
            x = this:getX() + 63,
            y = function()
                return this:getY() - 25
            end
        }
    }

    return this
end

function MegaTank:update(dt)
    if self:getY() >= 70 then
        self.speed = 0
    end
    self:move()
    self:collide()
    self:attack()
    if self.health <= 50 then
        self:megaAttack()
    end
    self:resetTimer(dt)
    self:die()
end

function MegaTank:render()
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

function MegaTank:attack()
    if self.shootTimer >= self.shootSpeed then
        self.shootTimer = 0
        local cannon = math.random(#self.cannons)
        local x, y = self.cannons[cannon].x, self.cannons[cannon].y()
        local bullet = EnemyBullet:new(x, y, self, "straight")
        self.enemyManager:addObject(bullet)
    end
end

function MegaTank:megaAttack()
    if self.megaAttackTimer >= self.megaAttackSpeed then
        self.megaAttackTimer = 0
        local x, y = self:getX(), self:getY() + self.height / 2
        local bullet = MegaBullet:new(x, y, self, "straight")
        self.enemyManager:addObject(bullet)
    end
end

function Boss:resetTimer(dt)
    self.shootTimer = self.shootTimer + dt
    self.megaAttackTimer = self.megaAttackTimer + dt
end
