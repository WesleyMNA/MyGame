require('src.model.Button')

StartButton = Button:extend('StartButton')

function StartButton:new()
    local this = {
        x = 15,
        y = WINDOW_HEIGHT/2
    }

    setmetatable(this, self)

    local path = 'assets/sprites/gui/menu/start.png'
    this:setSprite(path)

    return this
end

function StartButton:update(dt)
    if self:isClicked() then
        GUI_MANAGER:setCurrentGUI('map')
    end
end

local blinkTimer = 0
function StartButton:render()
    blinkTimer = blinkTimer + 1
    setColor(WHITE)
    if blinkTimer <= 20 then
        love.graphics.draw(self.sprite, self.x, self.y)
    elseif blinkTimer >= 40 then
        blinkTimer = 0
    end
end
