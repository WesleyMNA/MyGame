require("src.gui.menu.StartButton")
require("src.gui.menu.ConfigButton")
require("src.gui.menu.HangarButton")

Menu = {}
Menu.__index = Menu

function Menu:new(guiManager)
    local this = {
        class = "Menu",
        guiManager = guiManager,
        buttons = {
            startButton = StartButton:new(),
            configButton = ConfigButton:new(),
            hangarButton = HangarButton:new()
        }
    }

    setmetatable(this, self)
    return this
end

function Menu:update(dt)
    updateLoop(dt, self.buttons)
end

function Menu:render()
    renderLoop(self.buttons)
end
