local Image = require("libs.image")
local Player = Image:extend()

local playerData = {
    controls = { left = "a", right = "d" },
    shoot = "space",
}

function Player:new(sprite, posY, speed)
    Player.super.new(self, sprite, posY, speed)
    self.bulletColor = { math.random(0, 255) / 255, math.random(0, 255) / 255, math.random(0, 255) / 255 }
end

function Player:move(dt)
    if love.keyboard.isDown(playerData.controls.right) and self.posX < love.graphics.getWidth() - self.width then
        self.posX = self.posX + self.speed * dt
    end
    if love.keyboard.isDown(playerData.controls.left) and self.posX > 0 then
        self.posX = self.posX - self.speed * dt
    end
end

return Player
