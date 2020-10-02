require("src.gui.menu.Menu")
require("src.gui.config.Config")
require("src.gui.hangar.Hangar")
require("src.Map")

GUIManager = {}
GUIManager.__index = GUIManager

function GUIManager:new()
    local this = {
        class = "GUIManager",
        current_gui = "menu"
    }

    this.guis = {
        menu = Menu:new(this),
        hangar = Hangar:new(this),
        config = Config:new(this)
    }

    setmetatable(this, self)
    return this
end

function GUIManager:update(dt)
    function love.mousepressed(x, y, button)
        self.guis[self.current_gui]:update(dt)
    end

    if self.current_gui == "map" then
        self.guis[self.current_gui]:update(dt)
    end
end

function GUIManager:render()
    self.guis[self.current_gui]:render()
    lovePrint(self.current_gui)
end

function GUIManager:createMap()
    self.guis.map = Map:new()
end

function GUIManager:getGUI(gui)
    return self.guis[gui]
end

function GUIManager:setCurrentGUI(guiName)
    self.current_gui = guiName
end
