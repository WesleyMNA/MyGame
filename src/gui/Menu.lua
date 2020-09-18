require('src.gui.button.StartButton')
require('src.gui.button.ConfigButton')
require('src.gui.button.HangarButton')

Menu = {}
Menu.__index = Menu

function Menu:new()
    local this = {
        class = 'Menu',

        buttons = {
            startButton = StartButton:new(),
            configButton = ConfigButton:new(),
            hangarButton = HangarButton:new(),
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
