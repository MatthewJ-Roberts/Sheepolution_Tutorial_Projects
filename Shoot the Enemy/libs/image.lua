local Object = require("libs.classic")
local Image = Object:extend()

function Image:new(sprite, posY, speed)
    self.posX = (love.graphics.getWidth() / 2) - (sprite:getWidth() / 2)
    self.posY = posY
    self.width = sprite:getWidth()
    self.height = sprite:getHeight()
    self.speed = speed
    self.sprite = sprite
end

function Image:draw()
    love.graphics.draw(self.sprite, self.posX, self.posY)
end

return Image
