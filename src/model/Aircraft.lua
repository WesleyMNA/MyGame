Aircraft = {}
Aircraft.__index = Aircraft

function Aircraft:extend(type)
    local this = {
        class = type,

        speed = 300,
        bullets = {},
        specials = {},
        enableSpecial = false,
        cooldown = 0,

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
    updateLoop(dt, self.specials)
    -- self:attack()
    if self.enableSpecial then self:launchSpecial() end
    self:resetTimers(dt)
end

function Aircraft:render()
    renderLoop(self.bullets)
    renderLoop(self.specials)
    love.graphics.draw(
        self.sprite, self:getX(), self:getY(),
        0, self.scale.x, self.scale.y,
        self.width/2, self.height/2
    )

    self.collider:setLinearVelocity(0, 0)

    -- Draws a target that shows the range of bombs
    if self.launchBombs then self:drawTarget() end
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

function Aircraft:resetTimers(dt)
    self.shootTimer = self.shootTimer + dt
    self.specialTimer = self.specialTimer + dt
end

function Aircraft:destroyBullet(bullet)
    local index = table.indexOf(self.bullets, bullet)
    table.remove(self.bullets, index)
    bullet.collider:destroy()
end

function Aircraft:destroySpecial(special)
    local index = table.indexOf(self.specials, special)
    table.remove(self.specials, index)
    special.collider:destroy()
end

function Aircraft:createCollider(x, y)
    self.collider = WORLD:newCircleCollider(x, y, 16)
    self.collider:setCollisionClass('Player')
    self.collider:setCategory(PLAYER_CATEGORY.collider)

    -- Do not collide with land vehicles or it weapons
    self.collider:setMask(
        ENEMY_CATEGORY.landCollider,
        PLAYER_CATEGORY.bullet,
        PLAYER_CATEGORY.bomb,
        PLAYER_CATEGORY.fallingBomb
    )
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

function Aircraft:getPosition()
    return self.collider:getPosition()
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
        local x = self:getX()
        local y = self:getY() - self.height/2
        return bulletClass:new(x, y, self)
    end
end

function Aircraft:setSpecialCooldown(number)
    self.specialCooldown = number
end