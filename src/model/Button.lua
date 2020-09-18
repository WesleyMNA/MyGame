Button = {}
Button.__index = Button

function Button:extend(type)
    local this = {
        class = type
    }

    this.__index = this

    setmetatable(this, self)
    return this
end

function Button:render()
    setColor(WHITE)
    love.graphics.draw(self.sprite, self.x, self.y)
end

function Button:screenTouched()
    if #love.touch.getTouches() == 0 then return false end
    return true
end

function Button:mousePressed()
    if love.mouse.isDown(1) then return true end
    return false
end

function Button:isClicked()
    if self:mousePressed() or self:screenTouched() then
        return self:getMouseClick() or self:getTouchClick()
    end
    return false
end

function Button:isInButton(x, y)
    return x > self.x and x < self.x + self.width and
    y > self.y and y < self.y + self.height
end


function Button:getTouchClick()
    local bool = false
    local touches = love.touch.getTouches()
    for i, id in ipairs(touches) do
        local x, y = love.touch.getPosition(id)
        bool = self:isInButton(x, y)
        if bool then break end
    end
    return bool
end

function Button:getMouseClick()
    local x, y = love.mouse.getPosition()
    return self:isInButton(x, y)
end

function Button:setSprite(path)
    self.sprite = love.graphics.newImage(path)
    self.width = self.sprite:getWidth()
    self.height = self.sprite:getHeight()
end

function Button:setController(controller)
    self.controller = controller
end
