local Object = require("libs.classic")

local Rectangle = Object:extend()

function Rectangle:new(posX, posY, color)
    self.posX = posX
    self.posY = posY
    self.width = 10
    self.height = 50
    self.speed = 1000
    self.color = color
end

function Rectangle:move(dt)
    if self.posY < love.graphics.getHeight() - self.height then
        self.posY = self.posY + self.speed * dt
        return true
    end
    return false
end

function Rectangle:draw()
    -- Drawing a rectangle filled with the random color + a white outline
    love.graphics.setColor(self.color)
    love.graphics.rectangle("fill", self.posX, self.posY, self.width, self.height)
    love.graphics.setColor(1, 1, 1)
    love.graphics.rectangle("line", self.posX, self.posY, self.width, self.height)
end

return Rectangle
