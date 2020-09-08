require('src.Map')
require('src.util.Util')
require('src.util.Color')
require('src.gui.Controller')
require('src.util.CreateCollisionClasses')

local wf = require 'libs.windfield'

WORLD = wf.newWorld(0, 0, true)
createCollisionClasses()

MAP = Map:new()

local controller

function love.load()
    controller = Controller:new()
end

function love.update(dt)
    MAP:update(dt)
    WORLD:update(dt)
    controller:update(dt)
end

function love.draw()
    MAP:render()
    -- WORLD:draw()
    controller:render()


    setColor(WHITE)
    local windownDimentions = 'WIDTH: '.. WINDOW_WIDTH ..' HEIGHT: '.. WINDOW_HEIGHT
    lovePrint(windownDimentions)

    local o = 'Orientation: '.. love.window.getDisplayOrientation()
    lovePrint(o, 0, 20)

    local x, y = MAP.player:getPosition()
    local player = 'X: '.. math.floor(x) ..' Y: '.. math.floor(y)
    lovePrint(player, 0, 40)
end
