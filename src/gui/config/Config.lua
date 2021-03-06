require("src.gui.button.MenuButton")

Config = {}
Config.__index = Config

function Config:new(guiManager)
    local this = {
        class = "Config",
        guiManager = guiManager,
        buttons = {
            menuButton = MenuButton:new()
        }
    }

    setmetatable(this, self)
    return this
end

function Config:update(dt)
    updateLoop(dt, self.buttons)
end

function Config:render()
    renderLoop(self.buttons)
end
