MobileEnemy = {}
MobileEnemy.__index = MobileEnemy

function MobileEnemy:extend(type)
    local this = {
        class = type,
        health = 1,
        speed = 150,
        direction = {
            x = 1,
            y = 1
        },
        scale = {
            x = 1,
            y = 1
        }
    }

    this.__index = this

    setmetatable(this, self)
    return this
end

function MobileEnemy:update(dt)
    -- Some enemies have animations to update
    if self.animation then
        self.animation:update(dt)
    end

    self:move()
    self:collide()
    self:attack()
    self:resetTimer(dt)
    self:die()
end

function MobileEnemy:render()
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

function MobileEnemy:move()
    local y = self.speed * self.direction.y
    self.collider:setLinearVelocity(0, y)
end

function MobileEnemy:attack()
    if self.shootTimer >= self.shootSpeed then
        self.shootTimer = 0
        local bullet = self.bulletClass()
        self.enemyManager:addObject(bullet)
    end
end

function MobileEnemy:resetTimer(dt)
    self.shootTimer = self.shootTimer + dt
end

function MobileEnemy:collide()
    -- Both types of vehicles will collide with bullets
    if self.collider:enter("PlayerBullet") then
        self.health = self.health - PlayerBullet.damage
    end

    -- Only air vehicle will collide with player
    if self.collider:enter("Player") then
        self.health = self.health - 1
    end

    -- Only land vehicle will collide with bombs
    if self.collider:enter("Bomb") then
        local collision_data = self.collider:getEnterCollisionData("Bomb")
        local bomb = collision_data.collider:getObject()
        self.health = self.health - bomb.damage
    end
end

function MobileEnemy:die()
    if self.health <= 0 then
        self.enemyManager:destroyEnemy(self)
        return
    end

    if self:getY() >= WINDOW_HEIGHT then
        self.enemyManager:destroyEnemy(self)
    end
end

function MobileEnemy:createAirCollider(x, y, r)
    self.collider = WORLD:newCircleCollider(x, y, r)
    self.collider:setCollisionClass("Enemy")
    self.collider:setCategory(ENEMY_CATEGORY.airCollider)

    -- Do not collide with land vehicles or bombs
    self.collider:setMask(
        ENEMY_CATEGORY.airCollider,
        ENEMY_CATEGORY.landCollider,
        ENEMY_CATEGORY.bullet,
        PLAYER_CATEGORY.bomb,
        PLAYER_CATEGORY.fallingBomb
    )
end

function MobileEnemy:createLandCollider(x, y, r)
    self.collider = WORLD:newCircleCollider(x, y, r)
    self.collider:setCollisionClass("Enemy")
    self.collider:setCategory(ENEMY_CATEGORY.landCollider)

    -- Do not collide with aircrafts
    self.collider:setMask(
        ENEMY_CATEGORY.airCollider,
        ENEMY_CATEGORY.landCollider,
        ENEMY_CATEGORY.bullet,
        PLAYER_CATEGORY.collider,
        PLAYER_CATEGORY.fallingBomb
    )
end

function MobileEnemy:getPosition()
    return self.collider:getPosition()
end

function MobileEnemy:getX()
    return self.collider:getX()
end

function MobileEnemy:getY()
    return self.collider:getY()
end

function MobileEnemy:setSprite(path)
    self.sprite = love.graphics.newImage(path)
    self.width = self.sprite:getWidth()
    self.height = self.sprite:getHeight()
end

function MobileEnemy:setEnemyManager(enemyManager)
    self.enemyManager = enemyManager
end

function MobileEnemy:setShotSpeed(speed)
    self.shootSpeed = speed
    self.shootTimer = speed
end

function MobileEnemy:setBulletClass(bulletClass, movement)
    self.bulletClass = function()
        local x = self:getX()
        local y = self:getY() -- + self.height/2
        return bulletClass:new(x, y, self, movement)
    end
end
