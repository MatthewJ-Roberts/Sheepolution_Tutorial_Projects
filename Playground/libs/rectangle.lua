local Object = require("libs.classic")

local Rectangle = Object:extend()

function Rectangle:new(players)
    self.posX = 0
    self.posY = 0
    self.mode = "fill"
    self.speed = 100
    self.player = players
end

function Rectangle:move(dt)
    local controls = {
        [1] = {up = "w", down = "s", left = "a", right = "d"},
        [2] = {up = "up", down = "down", left = "left", right = "right"}
    }

    local playerControls = controls[self.player]

    if love.keyboard.isDown(playerControls.right) then
        self.posX = self.posX + self.speed * dt
    end
    if love.keyboard.isDown(playerControls.left) then
        self.posX = self.posX - self.speed * dt
    end
    if love.keyboard.isDown(playerControls.up) then
        self.posY = self.posY - self.speed * dt
    end
    if love.keyboard.isDown(playerControls.down) then
        self.posY = self.posY + self.speed * dt
    end
end

function Rectangle:changeSpeed(key)
    local controls = {
        [1] = "lctrl",
        [2] = ","
    }

    local playerControls = controls[self.player]

    if key == playerControls then
        -- Lua ternary operator
        self.speed = self.speed < 500 and self.speed + 100 or 100
    end
end

function Rectangle:changeMode(key)
    local controls = {
        [1] = "space",
        [2] = "m"
    }

    local playerControls = controls[self.player]

    if key == playerControls then
        -- Lua ternary operator
        self.mode = self.mode == "fill" and "line" or "fill"
    end
end

return Rectangle