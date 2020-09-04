require('src.model.LandVehicle')

Tank = LandVehicle:extend('Tank')

function Tank:new(x, y, enemyManager)
    local this = {

    }

    setmetatable(this, self)

    local path = 'assets/sprites/enemy/tank.png'
    this:setSprite(path)

    this:createCollider(x, y, 16)

    this:setEnemyManager(enemyManager)

    return this
end
