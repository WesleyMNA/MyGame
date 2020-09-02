Aircraft = {}
Aircraft.__index = Aircraft

function Aircraft:extend(type)
    local this = {
        class = type,

        speed = 300,
        bullets = {},

        scale = {
            x = 1,
            y = 1
        }
    }
    
    this.__index = this

    setmetatable(this, self)
    return this
end

function Aircraft:update(dt)
    updateLoop(dt, self.bullets)
    self:attack()
    self:resetShoot(dt)
end

function Aircraft:render()
    renderLoop(self.bullets)
    love.graphics.draw(
        self.sprite, self:getX(), self:getY(),
        0, self.scale.x, self.scale.y,
        self.width/2, self.height/2
    )
end

function Aircraft:move(x, y, dt)
    if self:getY() > y then
        self:setY(self:getY() - self.speed * dt)
    end
    if self:getY() < y and not self:isOnBottomEdge() then
        self:setY(self:getY() + self.speed * dt)
    end
    if  self:getX() > x and not self:isOnLeftEdge() then
        self:setX(self:getX() - self.speed * dt)
    end
    if  self:getX() < x and not self:isOnRightEdge() then
        self:setX(self:getX() + self.speed * dt)
    end
end

function Aircraft:attack()
    if self.shootTimer >= self.shootSpeed then
        self.shootTimer = 0
        local bullet = self.bulletClass()
        table.insert(self.bullets, bullet)
    end
end

function Aircraft:resetShoot(dt)
    self.shootTimer = self.shootTimer + dt
end

function Aircraft:destroyBullet(bullet)
    local index = table.indexOf(self.bullets, bullet)
    table.remove(self.bullets, index)
    bullet.collider:destroy()
end

function Aircraft:createCollider(x, y)
    self.collider = WORLD:newCircleCollider(x, y, 16)
    self.collider:setCollisionClass('Player')
    self.collider:setCategory(PLAYER_CATEGORY.collider)
end

function Aircraft:isOnRightEdge()
    if self:getX() + self.width/2 >= WINDOW_WIDTH then
        return true
    end
    return false
end

function Aircraft:isOnLeftEdge()
    if self:getX() - self.width/2 <= 0 then
        return true
    end
    return false
end

function Aircraft:isOnBottomEdge()
    if self:getY() + self.height/2 >= WINDOW_HEIGHT then
        return true
    end
    return false
end

function Aircraft:getX()
    return self.collider:getX()
end

function Aircraft:getY()
    return self.collider:getY()
end

function Aircraft:setX(x)
    self.collider:setX(x)
end

function Aircraft:setY(y)
    self.collider:setY(y)
end

function Aircraft:setSprite(path)
    self.sprite = love.graphics.newImage(path)
    self.width = self.sprite:getWidth()
    self.height = self.sprite:getHeight()
end

function Aircraft:setShotSpeed(speed)
    self.shootSpeed = speed
    self.shootTimer = speed
end

function Aircraft:setBulletClass(bulletClass)
    self.bulletClass = function ()
        return bulletClass:new(self:getX(), self:getY(), self)
    end
end