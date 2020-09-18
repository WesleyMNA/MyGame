require('src.Map')
require('src.util.Util')
require('src.util.Color')
require('src.gui.GUIManager')
require('src.util.CreateCollisionClasses')

local wf = require 'libs.windfield'

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
