require("src.model.Button")

RightButton = Button:extend("RightButton")

function RightButton:new(hangar)
    local this = {
        hangar = hangar
    }

    setmetatable(this, self)

    local path = "assets/sprites/gui/buttons/right.png"
    this:setSprite(path)

    this.x = WINDOW_WIDTH - this.width
    this.y = WINDOW_HEIGHT / 2

    return this
end

function RightButton:update(dt)
    if self:isClicked() then
        local numberOfAircrafts = self.hangar.aircraftsManager:getNumberOfAircrafts()
        if self.hangar.currentId < numberOfAircrafts then
            self.hangar.currentId = self.hangar.currentId + 1
        else
            self.hangar.currentId = 1
        end
    end
end

function RightButton:render()
    setColor(WHITE)
    love.graphics.draw(self.sprite, self.x, self.y)
end
