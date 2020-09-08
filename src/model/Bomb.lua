require('src.Animation')

Bomb = {}
Bomb.__index = Bomb

function Bomb:extend(type)
    local this = {
        class = type,
        
        state = 'move',
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
    self.animations[self.state]:update(dt)
end

function Bomb:render()
    love.graphics.draw(
        self.spritesheet, self.quad,
        self:getX(), self:getY(),
        0, self.scale.x, self.scale.y,
        self.width/2, self.height/2
    )
end

function Bomb:move()
    local direction
    if self.state == 'move' then
        direction = self.speed * self.scale.y
    else
        direction = 0
    end

    self.collider:setLinearVelocity(0, direction)
end

function Bomb:collide()
    if self:isOutOfRange() then
        self.state = 'collide'
        self.collider:setCategory(PLAYER_CATEGORY.bomb) -- Changes category to collide with land enemies
    end

    if self.state == 'collide' and self.animations[self.state]:hasFinished() then
        self.aircraft:destroySpecial(self)
    end
end

function Bomb:createCollider(x, y, r)
    self.collider = WORLD:newCircleCollider(x, y, r)
    self.collider:setCollisionClass('Bomb')
    self.collider:setCategory(PLAYER_CATEGORY.fallingBomb)

    self.collider:setObject(self)

    -- Do not collide with aircrafts
    self.collider:setMask(
        PLAYER_CATEGORY.collider,
        PLAYER_CATEGORY.fallingBomb,
        ENEMY_CATEGORY.airCollider,
        ENEMY_CATEGORY.bullet
    )
end

function Bomb:createAnimation()
    self.quad = love.graphics.newQuad(0, 0, self.width, self.height, self.spritesheet:getDimensions())
    local moveData = {
        fps = 10,
        frames = 1,
        xoffsetMul = self.width,
        yoffset = 0,
        loop = true
    }
    local collideData = {
        fps = 10,
        frames = 3,
        xoffsetMul = self.width,
        yoffset = self.height,
        loop = false
    }
    self.animations = {
        move = Animation:new(self.quad, moveData),
        collide = Animation:new(self.quad, collideData)
    }
end

function Bomb:isOutOfRange()
    local distance = self:getY() - self.startY
    if self:getY() < 30 or
    distance >= self.range or
    distance <= -self.range then
        return true
    end
    return false
end

function Bomb:getPosition()
    return self.collider:getPosition()
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

function Bomb:setSpritesheet(path)
    self.spritesheet = love.graphics.newImage(path)
    self.width = TILE_SIZE
    self.height = TILE_SIZE
    self:createAnimation()
end

function Bomb:setStartY(y)
    self.startY = y
end