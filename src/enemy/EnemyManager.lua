require('src.enemy.Tank')
require('src.enemy.Boss')
require('src.enemy.Helicopter')
require('src.enemy.FixedCannon')

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

    if #self.enemiesInScene <= 0 then
        local x = WINDOW_WIDTH/2
        local boss = Boss:new(x, -100, self)
        self:addEnemy(boss)
    end

    -- t = t + dt

    -- if t >= 3 then
    --     local delimiter = 50
    --     local x, y = math.random(0+delimiter, WINDOW_WIDTH-delimiter), 0
    --     local random = math.random(3)
    --     if random == 1 then
    --         local tank = Tank:new(x, y, self)
    --         self:addEnemy(tank)
    --     elseif random == 2 then
    --         local fixedCannon = FixedCannon:new(x, y, self)
    --         self:addEnemy(fixedCannon)
    --     else
    --         local helicopter = Helicopter:new(x, y, self)
    --         self:addEnemy(helicopter)
    --     end
    --     t = 0
    -- end
end

function EnemyManager:render()
    renderLoop(self.enemiesInScene)
    renderLoop(self.objectsInScene)

    local x = 250
    lovePrint('Enemies: '.. #self.enemiesInScene, x, 0)
    lovePrint('Objects: '.. #self.objectsInScene, x, 20)
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
