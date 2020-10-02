require("src.model.Button")

BuyButton = Button:extend("BuyButton")

function BuyButton:new(x, y)
    local this = {
        isAircraftActivated = true
    }

    setmetatable(this, self)

    local path = "assets/sprites/gui/hangar/select.png"
    this:setSprite(path)

    this.x = x or WINDOW_WIDTH - this.width
    this.y = y or WINDOW_HEIGHT - this.height

    return this
end

function BuyButton:update(dt)
    if self:isClicked() then
        if self.isAircraftActivated then
            GUI_MANAGER:setCurrentGUI('menu')
        else
            AIRCRAFTS_MANAGER:activateAircraft()
        end
    end
end

function BuyButton:render()
    self:changeSprite()
    setColor(WHITE)
    love.graphics.draw(self.sprite, self.x, self.y)
end

function BuyButton:changeSprite()
    local path
    if self.isAircraftActivated then
        path = "assets/sprites/gui/hangar/select.png"
    else
        path = "assets/sprites/gui/hangar/buy.png"
    end

    self:setSprite(path)
end

function BuyButton:setIsAircraftActivated(bool)
    self.isAircraftActivated = bool
end
