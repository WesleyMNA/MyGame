require("src.Map")
require("src.util.Util")
require("src.util.Color")
require("src.gui.GUIManager")
require("src.util.CreateCollisionClasses")

local wf = require "libs.windfield"

WORLD = wf.newWorld(0, 0, false)
createCollisionClasses()

MAP = Map:new()

GUI_MANAGER = GUIManager:new()

function love.load()
end

function love.update(dt)
    GUI_MANAGER:update(dt)
end

function love.draw()
    setColor(WHITE)
    GUI_MANAGER:render()
end
