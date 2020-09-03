require('src.gui.SpecialButton')

Controller = {}
Controller.__index = Controller

function Controller:new()
    local this = {
        class = 'Controller',

        player = MAP.player
    }

    this.special = SpecialButton:new(0, WINDOW_HEIGHT-50, this)

    setmetatable(this, self)
    return this
end

function Controller:update(dt)
    self.special:update(dt)
    self:movePlayer(dt)
end

function Controller:render()
    self.special:render()
end

function Controller:movePlayer(dt)
    if self:screenTouched() then
        if not self:isAnyButtonClicked() then
            local firstTouch = love.touch.getTouches()[1]
            local x, y = love.touch.getPosition(firstTouch)
            y = y - 20
            self.player:move(x, y, dt)
        end
    end

    if self:mousePressed() then
        if not self:isAnyButtonClicked() then
            local x, y = love.mouse.getPosition()
            y = y - 20
            self.player:move(x, y, dt)
        end
    end
end

function Controller:screenTouched()
    if #love.touch.getTouches() == 0 then return false end
    return true
end

function Controller:mousePressed()
    if love.mouse.isDown(1) then return true end
    return false
end

function Controller:isAnyButtonClicked()
    return self.special:isClicked()
end