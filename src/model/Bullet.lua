Bullet = {}
Bullet.__index = Bullet

function Bullet:extend(type)
    local this = {
        class = type,
        damage = 1,
        speed = 600
    }

    this.__index = this

    setmetatable(this, self)
    return this
end

function Bullet:update(dt)
    self:move(dt)
    self:collide()
end

function Bullet:render()
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

function Bullet:move(dt)
    local direction = self.speed * self.scale.y
    self.collider:setLinearVelocity(0, direction)
end

function Bullet:createCollider(x, y)
    self.collider = WORLD:newCircleCollider(x, y, 2)
end

function Bullet:isOutOfScreen()
    local xBool = self:getX() <= 0 or self:getX() >= WINDOW_WIDTH
    local yBool = self:getY() <= 0 or self:getY() >= WINDOW_HEIGHT
    return xBool or yBool
end

function Bullet:getPosition()
    return self.collider:getPosition()
end

function Bullet:getX()
    return self.collider:getX()
end

function Bullet:getY()
    return self.collider:getY()
end

function Bullet:setX(x)
    self.collider:setX(x)
end

function Bullet:setY(y)
    self.collider:setY(y)
end

function Bullet:setShooter(shooter)
    self.shooter = shooter
end

function Bullet:setShooter(shooter)
    self.shooter = shooter
end

function Bullet:setEnemyManager(enemyManager)
    self.enemyManager = enemyManager
end

function Bullet:setSprite(path)
    self.sprite = love.graphics.newImage(path)
    self.width = self.sprite:getWidth()
    self.height = self.sprite:getHeight()
end
