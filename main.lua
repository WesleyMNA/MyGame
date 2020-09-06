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
    WORLD:draw()
    controller:render()

    setColor(WHITE)
    love.graphics.print(WINDOW_WIDTH)
    love.graphics.print(WINDOW_HEIGHT, 0, 20)
end
