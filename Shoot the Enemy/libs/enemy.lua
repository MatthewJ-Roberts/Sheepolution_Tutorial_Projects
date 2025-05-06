local Image = require("libs.image")
local Enemy = Image:extend()

function Enemy:new(sprite, posY, speed)
    Enemy.super.new(self, sprite, posY, speed)
    self.direction = "right"
end

function Enemy:move(dt)
    if self.posX < love.graphics.getWidth() - self.width and self.direction == "right" then
        self.posX = self.posX + self.speed * dt
    else
        self.direction = "left"
    end
    if self.posX > 0 and self.direction == "left" then
        self.posX = self.posX - self.speed * dt
    else
        self.direction = "right"
    end
end

function Enemy:increaseSpeed(dt)
    self.speed = self.speed + love.graphics.getWidth() * 2 * dt
end

return Enemy
