require('src.model.Button')

SpecialButton = Button:extend('SpecialButton')

function SpecialButton:new(x, y, controller)
    local this = {
        x = x,
        y = y,

        player = MAP.player,
        cooldown = MAP.player.specialCooldown
    }

    this.timer = this.cooldown

    setmetatable(this, self)

    local path = 'assets/sprites/gui/special.png'
    this:setSprite(path)

    this:setController(controller)

    return this
end

function SpecialButton:update(dt)
    if self:isSpecialReady() and self:isClicked() or love.keyboard.isDown('space') then
        self.timer = 0
        self.player.enableSpecial = true
    end
    self.timer = self.timer + dt
end

function SpecialButton:render()
    local alpha = self.timer / self.cooldown
    local color = addAlpha(WHITE, alpha)
    setColor(color)
    love.graphics.draw(self.sprite, self.x, self.y)
end

function SpecialButton:isSpecialReady()
    return self.timer >= self.cooldown
end
