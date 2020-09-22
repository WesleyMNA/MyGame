require("src.gui.button.MenuButton")
require("src.gui.button.BuyButton")
require("src.gui.button.LeftButton")
require("src.gui.button.RightButton")
require("src.player.AircraftsManager")

Hangar = {}
Hangar.__index = Hangar

function Hangar:new()
    local this = {
        class = "Hangar",
        aircraftsManager = AircraftsManager:new(),
        currentId = 1,
        buttons = {
            menuButton = MenuButton:new(),
            buyButton = BuyButton:new()
        }
    }

    this.buttons.leftButton = LeftButton:new(this)
    this.buttons.rightButton = RightButton:new(this)

    setmetatable(this, self)
    return this
end

function Hangar:update(dt)
    updateLoop(dt, self.buttons)
end

function Hangar:render()
    renderLoop(self.buttons)

    self.currentAircraftData = self.aircraftsManager:getAircraft(self.currentId)
    local aircraftSprite = self.currentAircraftData.aircraft.sprite
    love.graphics.draw(aircraftSprite, 150, 300)
end
