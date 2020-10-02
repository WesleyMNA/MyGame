require("src.model.Button")

RightButton = Button:extend("RightButton")

function RightButton:new(aircraftsManager)
    local this = {
        aircraftsManager = aircraftsManager
    }

    setmetatable(this, self)

    local path = "assets/sprites/gui/hangar/right.png"
    this:setSprite(path)

    this.x = WINDOW_WIDTH - this.width
    this.y = WINDOW_HEIGHT / 2

    return this
end

function RightButton:update(dt)
    if self:isClicked() then
        local numberOfAircrafts = self.aircraftsManager:getNumberOfAircrafts()
        if self.aircraftsManager.currentAircraftId < numberOfAircrafts then
            self.aircraftsManager.currentAircraftId = self.aircraftsManager.currentAircraftId + 1
        else
            self.aircraftsManager.currentAircraftId = 1
        end
    end
end

function RightButton:render()
    setColor(WHITE)
    love.graphics.draw(self.sprite, self.x, self.y)
end
