require("src.model.Button")

BuyButton = Button:extend("BuyButton")

function BuyButton:new(x, y)
    local this = {}

    setmetatable(this, self)

    local path = "assets/sprites/gui/buttons/buy.png"
    this:setSprite(path)

    this.x = x or WINDOW_WIDTH - this.width
    this.y = y or WINDOW_HEIGHT - this.height

    return this
end

function BuyButton:update(dt)
    if self:isClicked() then
    end
end

function BuyButton:render()
    setColor(WHITE)
    love.graphics.draw(self.sprite, self.x, self.y)
end
