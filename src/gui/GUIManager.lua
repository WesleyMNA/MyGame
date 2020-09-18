require('src.gui.Menu')
require('src.gui.Config')
require('src.gui.Hangar')


GUIManager = {}
GUIManager.__index = GUIManager

function GUIManager:new()
    local this = {
        class = 'GUIManager',

        current_gui = 'menu'
    }

    this.guis = {
        menu = Menu:new(),
        hangar = Hangar:new(),
        config = Config:new(),
        map = MAP
    }

    setmetatable(this, self)
    return this
end

function GUIManager:update(dt)
    self.guis[self.current_gui]:update(dt)
end

function GUIManager:render()
    self.guis[self.current_gui]:render()
    lovePrint(self.current_gui)
end

function GUIManager:setCurrentGUI(guiName)
    self.current_gui = guiName
end
