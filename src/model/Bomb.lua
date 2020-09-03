Bomb = {}
Bomb.__index = Bomb

function Bomb:extend(type)
    local this = {
        class = type,

        speed = 600,
        range = 400
    }

    this.__index = this

    setmetatable(this, self)
    return this
end

function Bomb:update(dt)
    self:move()
    self:collide()
end

function Bomb:render()
    love.graphics.draw(
        self.sprite, self:getX(), self:getY(),
        0, self.scale.x, self.scale.y,
        self.width/2, self.height/2
    )
end

function Bomb:move()
    local direction = self.speed * self.scale.y
    self.collider:setLinearVelocity(0, direction)
end

function Bomb:createCollider(x, y, r)
    self.collider = WORLD:newCircleCollider(x, y, r)
end

function Bomb:collide()
    if self:isOutOfRange() then
        self.aircraft:destroySpecial(self)
    end
end

function Bomb:isOutOfRange()
    local distance = self:getY() - self.startY
    if self:getY() < 0 or
    distance >= self.range or
    distance <= -self.range then
        return true
    end
    return false
end

function Bomb:getX()
    return self.collider:getX()
end

function Bomb:getY()
    return self.collider:getY()
end

function Bomb:setAircraft(aircraft)
    self.aircraft = aircraft
end

function Bomb:setSprite(path)
    self.sprite = love.graphics.newImage(path)
    self.width = self.sprite:getWidth()
    self.height = self.sprite:getHeight()
end

function Bomb:setStartY(y)
    self.startY = y
end