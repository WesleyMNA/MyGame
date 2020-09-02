require('src.gui.SpecialButton')

Controller = {}
Controller.__index = Controller

function Controller:new(player)
    local this = {
        class = 'Controller',

        player = player,

        special = SpecialButton:new(0, WINDOW_HEIGHT-50)
    }

    setmetatable(this, self)
    return this
end

function Controller:update(dt)
    if self:screenTouched() then
        local firstTouch = love.touch.getTouches()[1]
        local x, y = love.touch.getPosition(firstTouch)
        y = y - 20
        self.player:move(x, y, dt)

        self.special:update(dt)
    end

    if self:mousePressed() then
        local x, y = love.mouse.getPosition()
        y = y - 20
        self.player:move(x, y, dt)

        self.special:update(dt)
    end
end

function Controller:render()
    self.special:render()
end

function Controller:screenTouched()
    if #love.touch.getTouches() == 0 then return false end
    return true
end

function Controller:mousePressed()
    if love.mouse.isDown(1) then return true end
    return false
end