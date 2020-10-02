require("src.model.Button")

LeftButton = Button:extend("LeftButton")

function LeftButton:new(aircraftsManager)
    local this = {
        aircraftsManager = aircraftsManager
    }

    setmetatable(this, self)

    local path = "assets/sprites/gui/hangar/left.png"
    this:setSprite(path)

    this.x = 0
    this.y = WINDOW_HEIGHT / 2

    return this
end

function LeftButton:update(dt)
    if self:isClicked() then
        local numberOfAircrafts = self.aircraftsManager:getNumberOfAircrafts()
        if self.aircraftsManager.currentAircraftId > 1 then
            self.aircraftsManager.currentAircraftId = self.aircraftsManager.currentAircraftId - 1
        else
            self.aircraftsManager.currentAircraftId = numberOfAircrafts
        end
    end
end

function LeftButton:render()
    setColor(WHITE)
    love.graphics.draw(self.sprite, self.x, self.y)
end
