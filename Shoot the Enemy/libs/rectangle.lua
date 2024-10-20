local Object = require("libs.classic")

local Rectangle = Object:extend()

local playerData = {
    [1] = {
        controls = { up = "w", down = "s", left = "a", right = "d" },
        speedToggle = "lctrl",
        modeToggle = "space",
        color = { 1, 0, 0 },
    },
    [2] = {
        controls = { up = "up", down = "down", left = "left", right = "right" },
        speedToggle = ",",
        modeToggle = "m",
        color = { 0, 1, 0 },
    },
    [3] = {
        controls = { up = "i", down = "k", left = "j", right = "l" },
        speedToggle = ";",
        modeToggle = "'",
        color = { 0, 0, 1 },
    },
}

function Rectangle:new(players)
    self.posX = 0
    self.posY = 0
    self.width = 100
    self.height = 100
    self.colliding = false
    self.mode = "fill"
    self.speed = 100
    self.player = players
end

function Rectangle:move(dt)
    if love.keyboard.isDown(playerData[self.player].controls.right) then
        self.posX = self.posX + self.speed * dt
    end
    if love.keyboard.isDown(playerData[self.player].controls.left) then
        self.posX = self.posX - self.speed * dt
    end
    if love.keyboard.isDown(playerData[self.player].controls.up) then
        self.posY = self.posY - self.speed * dt
    end
    if love.keyboard.isDown(playerData[self.player].controls.down) then
        self.posY = self.posY + self.speed * dt
    end
end

function Rectangle:changeSpeed(key)
    if key == playerData[self.player].speedToggle then
        -- Lua ternary operator
        self.speed = self.speed < 500 and self.speed + 100 or 100
    end
end

function Rectangle:changeMode(key)
    if key == playerData[self.player].modeToggle then
        -- Lua ternary operator
        self.mode = self.mode == "fill" and "line" or "fill"
    end
end

function Rectangle:draw()
    if self.colliding then
        self.mode = "line"
    else
        self.mode = "fill"
    end
    love.graphics.setColor(playerData[self.player].color)
    love.graphics.rectangle(self.mode, self.posX, self.posY, self.width, self.height)
    love.graphics.setColor(1, 1, 1)
end

return Rectangle
