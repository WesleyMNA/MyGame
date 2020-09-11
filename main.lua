require('src.Map')
require('src.util.Util')
require('src.util.Color')
require('src.gui.Controller')
require('src.util.CreateCollisionClasses')

local wf = require 'libs.windfield'

WORLD = wf.newWorld(0, 0, false)
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
    WORLD:draw(0.5)
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






--------------------------
-- function love.load()
--   world = wf.newWorld(0, 512, true)
--   world:addCollisionClass('Platform')
--   world:addCollisionClass('Player')
  
--   ground = world:newRectangleCollider(100, 500, 600, 50)
--   ground:setType('static')
--   platform = world:newRectangleCollider(350, 400, 100, 20)
--   platform:setType('static')
--   platform:setCollisionClass('Platform')
--   player = world:newRectangleCollider(390, 450, 20, 40)
--   player:setCollisionClass('Player')
  
--   player:setPreSolve(function(collider_1, collider_2, contact)
--     print(1)      

--   end)
-- end

-- function love.update(dt)
--     world:update(dt)
-- end

-- function love.draw()
--     world:draw()
-- end

-- function love.keypressed(key)
--   if key == 'space' then
--     player:applyLinearImpulse(0, -1000)
--   end
-- end
