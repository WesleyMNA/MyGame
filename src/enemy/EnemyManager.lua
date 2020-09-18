require('src.enemy.unit.TargetCannon')
require('src.enemy.unit.Helicopter')
require('src.enemy.unit.FixedCannon')
require('src.enemy.unit.Car')

require('src.enemy.boss.mega_tank.MegaTank')

EnemyManager = {}
EnemyManager.__index = EnemyManager

function EnemyManager:new(map)
    local this = {
        class = 'EnemyManager',

        player = map.player,
        bossTimer = 0,
        unitsTimer = 0,

        enemiesInScene = {},
        objectsInScene = {},
        bossesInScene = {}
    }

    setmetatable(this, self)
    return this
end

function EnemyManager:update(dt)
    self:countBossTimer(dt)
    self:countUnitsTimer(dt)
    updateLoop(dt, self.enemiesInScene)
    updateLoop(dt, self.bossesInScene)
    updateLoop(dt, self.objectsInScene)

    if self.bossTimer >= 30 and #self.bossesInScene <= 0 then
        local x = WINDOW_WIDTH/2
        local megaTank = MegaTank:new(x, -100, self)
        self:addBoss(megaTank)
        self.bossTimer = 0
        self.unitsTimer = -2
    end

    if self.unitsTimer >= 3 and #self.bossesInScene == 0 then
        local delimiter = 20
        local x, y = math.random(0+delimiter, WINDOW_WIDTH-delimiter), 0
        local random = math.random(4)
        if random == 1 then
            local targetCannon = TargetCannon:new(x, y, self)
            self:addEnemy(targetCannon)
        elseif random == 2 then
            local fixedCannon = FixedCannon:new(x, y, self)
            self:addEnemy(fixedCannon)
        elseif random == 3 then
            y = WINDOW_HEIGHT
            local car = Car:new(x, y, self)
            self:addEnemy(car)
        else
            local helicopter = Helicopter:new(x, y, self)
            self:addEnemy(helicopter)
        end
        self.unitsTimer = 0
    end
end

function EnemyManager:render()
    renderLoop(self.enemiesInScene)
    renderLoop(self.bossesInScene)
    renderLoop(self.objectsInScene)

    local x = 250
    lovePrint('Boss: '.. math.floor(self.bossTimer), x, 0)
    lovePrint('Unit: '.. math.floor(self.unitsTimer), x, 20)
end

function EnemyManager:countBossTimer(dt)
    if #self.bossesInScene <=0 then
        self.bossTimer = self.bossTimer + dt
    end
end

function EnemyManager:countUnitsTimer(dt)
    if #self.bossesInScene == 0 then
        self.unitsTimer = self.unitsTimer + dt
    end
end

function EnemyManager:addEnemy(enemy)
    table.insert(self.enemiesInScene, enemy)
end

function EnemyManager:destroyEnemy(enemy)
    local index = table.indexOf(self.enemiesInScene, enemy)
    table.remove(self.enemiesInScene, index)
    enemy.collider:destroy()
end

function EnemyManager:addBoss(boss)
    table.insert(self.bossesInScene, boss)
end

function EnemyManager:destroyBoss(boss)
    local index = table.indexOf(self.bossesInScene, boss)
    table.remove(self.bossesInScene, index)
    boss.collider:destroy()
end

function EnemyManager:addObject(object)
    table.insert(self.objectsInScene, object)
end

function EnemyManager:destroyObject(object)
    local index = table.indexOf(self.objectsInScene, object)
    table.remove(self.objectsInScene, index)
    object.collider:destroy()
end
