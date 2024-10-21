local Object = require("libs.classic")

local Bullet = Object:extend()

function Bullet:new(posX, posY, color)
    self.posX = posX
    self.posY = posY
    self.width = 10
    self.height = 50
    self.speed = love.graphics.getHeight() * 2
    self.color = color
end

function Bullet:move(dt)
    if self.posY < love.graphics.getHeight() - self.height then
        self.posY = self.posY + self.speed * dt
        return true
    end
    return false
end

function Bullet:draw()
    -- Drawing a rectangle filled with the random color + a white outline
    love.graphics.setColor(self.color)
    love.graphics.rectangle("fill", self.posX, self.posY, self.width, self.height)
    love.graphics.setColor(1, 1, 1)
    love.graphics.rectangle("line", self.posX, self.posY, self.width, self.height)
end

return Bullet
