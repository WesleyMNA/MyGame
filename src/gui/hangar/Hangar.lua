require("src.gui.button.MenuButton")
require("src.gui.hangar.BuyButton")
require("src.gui.hangar.LeftButton")
require("src.gui.hangar.RightButton")

Hangar = {}
Hangar.__index = Hangar

function Hangar:new(guiManager)
    local this = {
        class = "Hangar",
        aircraftsManager = AIRCRAFTS_MANAGER,
        guiManager = guiManager,
        buttons = {
            menuButton = MenuButton:new(),
            buyButton = BuyButton:new()
        }
    }

    this.currentAircraftData = this.aircraftsManager:getCurrentAircraft()
    this.buttons.leftButton = LeftButton:new(this.aircraftsManager)
    this.buttons.rightButton = RightButton:new(this.aircraftsManager)

    setmetatable(this, self)
    return this
end

function Hangar:update(dt)
    updateLoop(dt, self.buttons)

    local bool = self.aircraftsManager:isCurrentAircraftActivated()
    self.buttons.buyButton:setIsAircraftActivated(bool)
end

function Hangar:render()
    renderLoop(self.buttons)
    local aircraftSprite = self.aircraftsManager:getCurrentAircraftSprite()
    love.graphics.draw(aircraftSprite, 150, 300)
end
