local Object = require("libs.classic")

local Circle = Object:extend()

function Circle:new()
    self.x = 0
    self.y = 0
    self.mode = "fill"
    self.canMove = true
    self.radius = math.random(5, 100)
end

function Circle:move(dt)
    if self.x < 300 then
        self.x = self.x + 100 * dt
        self.y = self.y + 100 * dt
    else
        self.canMove = false
        self.mode = "line"
    end
end

return Circle