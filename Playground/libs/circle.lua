local Object = require("libs.classic")

local Circle = Object:extend()

function Circle:new(x, y)
    -- If x or y are passed into the constructor, then set the object's value to the passed value
    -- Otherwise, they are nil, so set the object's value to 0
    self.x = x or 0
    self.y = y or 0
    self.mode = "fill"
    self.canMove = true
    self.radius = math.random(5, 100)
    self.color = { math.random(0, 255) / 255, math.random(0, 255) / 255, math.random(0, 255) / 255 }
end

function Circle:move(dt, cos, sin)
    if self.x < 300 or (cos and sin) then
        self.x = cos and self.x + 100 * cos * dt or self.x + 100 * dt
        self.y = sin and self.y + 100 * sin * dt or self.x + 100 * dt
    else
        self.canMove = false
        self.mode = "line"
    end
end

function Circle:draw()
    love.graphics.setColor(self.color)
    love.graphics.circle(self.mode, self.x, self.y, self.radius)
    love.graphics.setColor(1, 1, 1)
end

return Circle
