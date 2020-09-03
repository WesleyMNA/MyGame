require('src.model.Bomb')

FishbedSpecial = Bomb:extend('FishbedSpecial')

function FishbedSpecial:new(x, y, aircraft)
    local this = {
        scale = {
            x = 1,
            y = -1
        }
    }

    setmetatable(this, self)

    this:setAircraft(aircraft)

    local path = 'assets/sprites/player/fishbed/special.png'
    this:setSprite(path)

    this:createCollider(x, y, 3)
    this.collider:setCollisionClass('PlayerBullet')
    this.collider:setMask(PLAYER_CATEGORY.collider)

    this:setStartY(y)

    return this
end