require('src.gui.button.MenuButton')

Hangar = {}
Hangar.__index = Hangar

function Hangar:new()
    local this = {
        class = 'Hangar',

        buttons = {
            menuButton = MenuButton:new()
        }
    }

    setmetatable(this, self)
    return this
end

function Hangar:update(dt)
    updateLoop(dt, self.buttons)
end

function Hangar:render()
    renderLoop(self.buttons)
end