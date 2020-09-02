EnemyManager = {}
EnemyManager.__index = EnemyManager

function EnemyManager:new()
    local this = {
        class = 'EnemyManager',

        enemiesInScene = {},
        objectsInScene = {}
    }

    setmetatable(this, self)
    return this
end

function EnemyManager:update(dt)
    updateLoop(dt, self.enemiesInScene)
    updateLoop(dt, self.objectsInScene)
end

function EnemyManager:render()
    renderLoop(self.enemiesInScene)
    renderLoop(self.objectsInScene)
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
