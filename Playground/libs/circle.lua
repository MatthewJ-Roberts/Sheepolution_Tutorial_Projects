local circle = {}

function circle.createCircle()
    local circle = {}
    circle.x = 0
    circle.y = 0
    circle.mode = "fill"
    circle.move = true
    circle.radius = math.random(5, 100)
    return circle
end

function circle.moveCircle(dt, circ)
    if circ.x < 300 then
        circ.x = circ.x + 100 * dt
        circ.y = circ.y + 100 * dt
    else
        circ.move = false
        circ.mode = "line"
    end
end

return circle