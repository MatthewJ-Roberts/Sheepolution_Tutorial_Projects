local Object = require("libs.classic")

local Image = Object:extend()

local playerData = {
    controls = { left = "a", right = "d" },
    shoot = "space",
}

function Image:new(sprite, posY, speed)
    self.posX = (love.graphics.getWidth() / 2) - (sprite:getWidth() / 2)
    self.posY = posY
    self.width = sprite:getWidth()
    self.height = sprite:getHeight()
    self.speed = speed
    self.sprite = sprite
    self.direction = "right"
    self.bulletColor = { math.random(0, 255) / 255, math.random(0, 255) / 255, math.random(0, 255) / 255 }
end

function Image:movePlayer(dt)
    if love.keyboard.isDown(playerData.controls.right) and self.posX < love.graphics.getWidth() - self.width then
        self.posX = self.posX + self.speed * dt
    end
    if love.keyboard.isDown(playerData.controls.left) and self.posX > 0 then
        self.posX = self.posX - self.speed * dt
    end
end

function Image:moveEnemy(dt, direction)
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

function Image:increaseSpeed(dt)
    self.speed = self.speed + love.graphics.getWidth() * 2 * dt
end

function Image:draw()
    love.graphics.draw(self.sprite, self.posX, self.posY)
end

return Image
