require('src.enemy.Tank')
require('src.enemy.Helicopter')

EnemyManager = {}
EnemyManager.__index = EnemyManager

local t = 0

function EnemyManager:new(map)
    local this = {
        class = 'EnemyManager',

        player = map.player,

        enemiesInScene = {},
        objectsInScene = {}
    }

    setmetatable(this, self)
    return this
end

function EnemyManager:update(dt)
    updateLoop(dt, self.enemiesInScene)
    updateLoop(dt, self.objectsInScene)

    t = t + dt

    if t >= 3 then
        local x, y = math.random(0, WINDOW_WIDTH), 0
        -- local tank = Tank:new(x, y, self)
        -- self:addEnemy(tank)
        local helicopter = Helicopter:new(x, y, self)
        self:addEnemy(helicopter)
        t = 0
    end
end

function EnemyManager:render()
    renderLoop(self.enemiesInScene)
    renderLoop(self.objectsInScene)

    -- local x = 250
    -- love.graphics.print('Enemies: '.. #self.enemiesInScene, x, 0)
    -- love.graphics.print('Objects: '.. #self.objectsInScene, x, 20)
end

function EnemyManager:addEnemy(enemy)
    table.insert(self.enemiesInScene, enemy)
end

function EnemyManager:destroyEnemy(enemy)
    local index = table.indexOf(self.enemiesInScene, enemy)
    table.remove(self.enemiesInScene, index)
    enemy.collider:destroy()
end

function EnemyManager:addObject(object)
    table.insert(self.objectsInScene, object)
end

function EnemyManager:destroyObject(object)
    local index = table.indexOf(self.objectsInScene, object)
    table.remove(self.objectsInScene, index)
    object.collider:destroy()
end
