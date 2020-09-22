require("src.model.Button")

HangarButton = Button:extend("HangarButton")

function HangarButton:new()
    local this = {}

    setmetatable(this, self)

    local path = "assets/sprites/gui/buttons/hangar.png"
    this:setSprite(path)

    this.x = this.width / 2
    this.y = WINDOW_HEIGHT - this.height * 2

    return this
end

function HangarButton:update(dt)
    if self:isClicked() then
        GUI_MANAGER:setCurrentGUI("hangar")
    end
end

function HangarButton:render()
    setColor(WHITE)
    love.graphics.draw(self.sprite, self.x, self.y)
end
