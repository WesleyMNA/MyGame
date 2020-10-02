require("src.model.Button")

HangarButton = Button:extend("HangarButton")

function HangarButton:new()
    local this = {
        aircraftsManager = AIRCRAFTS_MANAGER
    }

    setmetatable(this, self)

    local path = "assets/sprites/gui/menu/hangar.png"
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

    local aircraftSprite = self.aircraftsManager:getCurrentAircraftSprite()
    local x = self.x + aircraftSprite:getWidth() / 1.7
    local y = self.y + aircraftSprite:getHeight() / 4
    love.graphics.draw(aircraftSprite, x, y)
end
