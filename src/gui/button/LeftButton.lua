require("src.model.Button")

LeftButton = Button:extend("LeftButton")

function LeftButton:new(hangar)
    local this = {
        hangar = hangar
    }

    setmetatable(this, self)

    local path = "assets/sprites/gui/buttons/left.png"
    this:setSprite(path)

    this.x = 0
    this.y = WINDOW_HEIGHT / 2

    return this
end

function LeftButton:update(dt)
    if self:isClicked() then
        local numberOfAircrafts = self.hangar.aircraftsManager:getNumberOfAircrafts()
        if self.hangar.currentId > 1 then
            self.hangar.currentId = self.hangar.currentId - 1
        else
            self.hangar.currentId = numberOfAircrafts
        end
    end
end

function LeftButton:render()
    setColor(WHITE)
    love.graphics.draw(self.sprite, self.x, self.y)
end
