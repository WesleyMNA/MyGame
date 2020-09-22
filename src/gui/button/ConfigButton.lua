require("src.model.Button")

ConfigButton = Button:extend("ConfigButton")

function ConfigButton:new()
    local this = {}

    setmetatable(this, self)

    local path = "assets/sprites/gui/buttons/config.png"
    this:setSprite(path)

    this.x = WINDOW_WIDTH - this.width * 1.5
    this.y = WINDOW_HEIGHT - this.height * 2

    return this
end

function ConfigButton:update(dt)
    if self:isClicked() then
        GUI_MANAGER:setCurrentGUI("config")
    end
end

function ConfigButton:render()
    setColor(WHITE)
    love.graphics.draw(self.sprite, self.x, self.y)
end
