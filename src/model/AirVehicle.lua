AirVehicle = {}
AirVehicle.__index = AirVehicle

function AirVehicle:extend(type)
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

function AirVehicle:update(dt)
    if self.animation then self.animation:update(dt) end

    self:move()
    self:collide()
    self:die()
end

function AirVehicle:render()
    love.graphics.draw(
        self.sprite, self:getX(), self:getY(),
        0, self.scale.x, self.scale.y,
        self.width/2, self.height/2
    )
end

function AirVehicle:move()
    direction = self.speed * self.scale.y
    self.collider:setLinearVelocity(0, direction)
end

function AirVehicle:collide()
    if self.collider:enter('PlayerBullet') then
        self.health = self.health - PlayerBullet.damage
    end

    if self.collider:enter('Player') then
        self.health = self.health - 1
    end
end

function AirVehicle:die()
    if self.health <= 0 then
        self.enemyManager:destroyEnemy(self)
        return
    end

    if self:getY() >= WINDOW_HEIGHT then self.enemyManager:destroyEnemy(self) end
end

function AirVehicle:createCollider(x, y, r)
    self.collider = WORLD:newCircleCollider(x, y, r)
    self.collider:setCollisionClass('Enemy')
    self.collider:setCategory(ENEMY_CATEGORY.airCollider)

    -- Do not collide with land vehicles
    self.collider:setMask(ENEMY_CATEGORY.landCollider)
    self.collider:setMask(PLAYER_CATEGORY.bomb)
    self.collider:setMask(PLAYER_CATEGORY.fallingBomb)
end

function AirVehicle:getX()
    return self.collider:getX()
end

function AirVehicle:getY()
    return self.collider:getY()
end

function AirVehicle:setSprite(path)
    self.sprite = love.graphics.newImage(path)
    self.width = self.sprite:getWidth()
    self.height = self.sprite:getHeight()
end

function AirVehicle:setEnemyManager(enemyManager)
    self.enemyManager = enemyManager
end
