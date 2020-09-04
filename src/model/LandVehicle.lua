LandVehicle = {}
LandVehicle.__index = LandVehicle

function LandVehicle:extend(type)
    local this = {
        class = type,

        health = 1,
        speed = 100,
        scale = {
            x = 1,
            y = 1
        }
    }

    this.__index = this

    setmetatable(this, self)
    return this
end

function LandVehicle:update(dt)
    self:move()
    self:collide()
    self:die()
end

function LandVehicle:render()
    love.graphics.draw(
        self.sprite, self:getX(), self:getY(),
        0, self.scale.x, self.scale.y,
        self.width/2, self.height/2
    )

    love.graphics.print(self.health, self:getX()-5, self:getY()-50)
end

function LandVehicle:move()
    direction = self.speed * self.scale.y
    self.collider:setLinearVelocity(0, direction)
end

function LandVehicle:collide()
    if self.collider:enter('PlayerBullet') then
        self.health = self.health - PlayerBullet.damage
    end

    if self.collider:enter('Bomb') then
        local collision_data = self.collider:getEnterCollisionData('Bomb')
        local bomb = collision_data.collider:getObject()
        self.health = self.health - bomb.damage
    end
end

function LandVehicle:die()
    if self.health <= 0 then
        self.enemyManager:destroyEnemy(self)
        return
    end

    if self:getY() >= WINDOW_HEIGHT then self.enemyManager:destroyEnemy(self) end
end

function LandVehicle:createCollider(x, y, r)
    self.collider = WORLD:newCircleCollider(x, y, r)
    self.collider:setCollisionClass('Enemy')
    self.collider:setCategory(ENEMY_CATEGORY.landCollider)

    -- Do not collide with aircrafts
    self.collider:setMask(ENEMY_CATEGORY.airCollider)
    self.collider:setMask(PLAYER_CATEGORY.collider)
    self.collider:setMask(PLAYER_CATEGORY.fallingBomb)
end

function LandVehicle:getX()
    return self.collider:getX()
end

function LandVehicle:getY()
    return self.collider:getY()
end

function LandVehicle:setSprite(path)
    self.sprite = love.graphics.newImage(path)
    self.width = self.sprite:getWidth()
    self.height = self.sprite:getHeight()
end

function LandVehicle:setEnemyManager(enemyManager)
    self.enemyManager = enemyManager
end
