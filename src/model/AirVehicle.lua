AirVehicle = {}
AirVehicle.__index = AirVehicle

function AirVehicle:extend(type)
    local this = {
        class = type,

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
    self:move()
    self:collide()
end

function AirVehicle:render()
    love.graphics.draw(
        self.sprite, self:getX(), self:getY(),
        0, self.scale.x, self.scale.y,
        self.width/2, self.height/2
    )
end

function AirVehicle:move()
    local direction
    if self.state == 'move' then
        direction = self.speed * self.scale.y
    else
        direction = 0
    end

    self.collider:setLinearVelocity(0, direction)
end

function AirVehicle:collide()

end

function AirVehicle:createCollider(x, y, r)
    self.collider = WORLD:newCircleCollider(x, y, r)
    self.collider:setCategory(ENEMY_CATEGORY.airCollider)
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
    self:setAnimation()
end