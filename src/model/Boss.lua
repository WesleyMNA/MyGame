Boss = {}
Boss.__index = Boss

function Boss:extend(type)
    local this = {
        class = type,

        health = 1,
        speed = 150,
        scale = {
            x = 1,
            y = 1
        }
    }

    this.__index = this

    setmetatable(this, self)
    return this
end

function Boss:update(dt)
    -- Some enemies have animations to update
    if self.animation then self.animation:update(dt) end

    self:move()
    self:collide()
    self:attack()
    self:resetTimer(dt)
    self:die()
end

function Boss:render()
    love.graphics.draw(
        self.sprite, self:getX(), self:getY(),
        0, self.scale.x, self.scale.y,
        self.width/2, self.height/2
    )
end

function Boss:move()
    local direction = self.speed * 1
    self.collider:setLinearVelocity(0, direction)
end

function Boss:attack()
    if self.shootTimer >= self.shootSpeed then
        self.shootTimer = 0
        local bullet = self.bulletClass()
        self.enemyManager:addObject(bullet)
    end
end

function Boss:resetTimer(dt)
    self.shootTimer = self.shootTimer + dt
end

function Boss:collide()
    -- Both types of vehicles will collide with bullets
    if self.collider:enter('PlayerBullet') then
        self.health = self.health - PlayerBullet.damage
    end

    -- Only air vehicle will collide with player
    if self.collider:enter('Player') then
        self.health = self.health - 1
    end

    -- Only land vehicle will collide with bombs
    if self.collider:enter('Bomb') then
        local collision_data = self.collider:getEnterCollisionData('Bomb')
        local bomb = collision_data.collider:getObject()
        self.health = self.health - bomb.damage
    end
end

function Boss:die()
    if self.health <= 0 then
        self.enemyManager:destroyBoss(self)
        return
    end

    if self:getY() >= WINDOW_HEIGHT then self.enemyManager:destroyBoss(self) end
end

function Boss:createAirCollider(x, y, w, h)
    self.collider = WORLD:newRectangleCollider(x, y, w, h)
    self.collider:setCollisionClass('Enemy')
    self.collider:setCategory(ENEMY_CATEGORY.airCollider)
    self.collider:setFixedRotation(true)

    -- Do not collide with land vehicles or bombs
    self.collider:setMask(
        ENEMY_CATEGORY.airCollider,
        ENEMY_CATEGORY.landCollider,
        ENEMY_CATEGORY.bullet,
        PLAYER_CATEGORY.bomb,
        PLAYER_CATEGORY.fallingBomb
    )
end

function Boss:createLandCollider(x, y, w, h)
    self.collider = WORLD:newRectangleCollider(x, y, w, h)
    self.collider:setCollisionClass('Enemy')
    self.collider:setCategory(ENEMY_CATEGORY.landCollider)
    self.collider:setFixedRotation(true)

    -- Do not collide with aircrafts
    self.collider:setMask(
        ENEMY_CATEGORY.airCollider,
        ENEMY_CATEGORY.landCollider,
        ENEMY_CATEGORY.bullet,
        PLAYER_CATEGORY.collider,
        PLAYER_CATEGORY.fallingBomb
    )
end

function Boss:getPosition()
    return self.collider:getPosition()
end

function Boss:getX()
    return self.collider:getX()
end

function Boss:getY()
    return self.collider:getY()
end

function Boss:setSprite(path)
    self.sprite = love.graphics.newImage(path)
    self.width = self.sprite:getWidth()
    self.height = self.sprite:getHeight()
end

function Boss:setEnemyManager(enemyManager)
    self.enemyManager = enemyManager
end

function Boss:setShotSpeed(speed)
    self.shootSpeed = speed
    self.shootTimer = speed
end

function Boss:setBulletClass(bulletClass, movement)
    self.bulletClass = function ()
        local x = self:getX()
        local y = self:getY() -- + self.height/2
        return bulletClass:new(x, y, self, movement)
    end
end
