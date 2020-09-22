require("src.model.Bomb")

FishbedSpecial = Bomb:extend("FishbedSpecial")

function FishbedSpecial:new(x, y, aircraft)
    local this = {
        damage = 5,
        scale = {
            x = 1,
            y = -1
        }
    }

    setmetatable(this, self)

    this:setAircraft(aircraft)

    local path = "assets/sprites/player/fishbed/special.png"
    this:setSpritesheet(path)

    this:createCollider(x, y, 10)

    this:setStartY(y)

    return this
end
