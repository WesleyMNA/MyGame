require("src.model.Bullet")

MegaBullet = Bullet:extend("MegaBullet")

function MegaBullet:new(x, y, shooter, movement)
    local this = {
        damage = 5,
        scale = {
            x = 1,
            y = -1
        },
        move = {},
        movement = movement,
        direction = {}
    }

    this.move.atPlayer = function(dt)
        local x = this.collider:getX() + dt * this.direction.x * this.speed
        local y = this.collider:getY() + dt * this.direction.y * this.speed
        this.collider:setX(x)
        this.collider:setY(y)
    end

    this.move.straight = function(dt)
        local y = this.collider:getY() + dt * this.speed
        this.collider:setY(y)
    end

    setmetatable(this, self)

    this:setEnemyManager(shooter.enemyManager)

    local path = "assets/sprites/enemy/boss/mega_bullet.png"
    this:setSprite(path)

    this:createCollider(x, y)
    this.collider:setCollisionClass("EnemyBullet")
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

function MegaBullet:update(dt)
    self.move[self.movement](dt)
    self:collide()
end

function MegaBullet:collide()
    if self:isOutOfScreen() or self:hitPlayer() then
        self.enemyManager:destroyObject(self)
    end
end

function MegaBullet:hitPlayer()
    return self.collider:enter("Player")
end

function MegaBullet:getDirection()
    local player = self.enemyManager.player

    local side = {}
    side.x = player:getX() - self:getX()
    side.y = player:getY() - self:getY()
    local hypotenuse = math.sqrt(side.x ^ 2 + side.y ^ 2)

    self.direction.x = side.x / hypotenuse
    self.direction.y = side.y / hypotenuse
end
