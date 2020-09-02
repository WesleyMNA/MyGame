require('src.model.Button')

SpecialButton = Button:extend('SpecialButton')

function SpecialButton:new(x, y)
    local this = {
        x = x,
        y = y
    }
   
    setmetatable(this, self)

    local path = 'assets/sprites/gui/special.png'
    this:setSprite(path)

    return this
end

function SpecialButton:update(dt)
    if self:isClicked() then
        print(1)
    end
end
