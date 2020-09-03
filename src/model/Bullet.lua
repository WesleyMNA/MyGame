Bullet = {}
Bullet.__index = Bullet

function Bullet:extend(type)
    local this = {
        class = type,

        speed = 600
    }

    this.__index = this

    setmetatable(this, self)
    return this
end

function Bullet:update(dt)
    self:move()
    self:collide()
end

function Bullet:render()
    love.graphics.draw(
        self.sprite, self:getX(), self:getY(),
        0, self.scale.x, self.scale.y,
        self.width/2, self.height/2
    )
end

function Bullet:move()
    local direction = self.speed * self.scale.y
    self.collider:setLinearVelocity(0, direction)
end

function Bullet:createCollider(x, y)
    self.collider = WORLD:newCircleCollider(x, y, 2)
end

function Bullet:getX()
    return self.collider:getX()
end

function Bullet:getY()
    return self.collider:getY()
end

function Bullet:setAircraft(aircraft)
    self.aircraft = aircraft
end

function Bullet:setSprite(path)
    self.sprite = love.graphics.newImage(path)
    self.width = self.sprite:getWidth()
    self.height = self.sprite:getHeight()
end