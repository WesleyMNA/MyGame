require('src.model.Button')

MenuButton = Button:extend('MenuButton')

function MenuButton:new(x, y)
    local this = {}

    setmetatable(this, self)

    local path = 'assets/sprites/gui/menu/menu.png'
    this:setSprite(path)

    this.x = x or 0
    this.y = y or WINDOW_HEIGHT - this.height

    return this
end

function MenuButton:update(dt)
    if self:isClicked() then
        GUI_MANAGER:setCurrentGUI('menu')
    end
end

function MenuButton:render()
    setColor(WHITE)
    love.graphics.draw(self.sprite, self.x, self.y)
end
