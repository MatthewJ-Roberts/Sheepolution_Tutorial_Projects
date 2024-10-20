-- Takes in a list of rectangles
function CheckColliding(rectangles)
    -- Resetting collision values
    for i, rect in ipairs(rectangles) do
        rect.colliding = false
    end
    -- Determining collisions
    for i = 1, #rectangles - 1 do
        for j = i + 1, #rectangles do
            AabbFormula(rectangles[i], rectangles[j])
        end
    end
end

-- Axis-Aligned Bounding Box collision detection
function AabbFormula(rect1, rect2)
    if
        rect1.posX + rect1.width > rect2.posX
        and rect1.posX < rect2.posX + rect2.width
        and rect1.posY + rect1.height > rect2.posY
        and rect1.posY < rect2.posY + rect2.height
    then
        rect1.colliding = true
        rect2.colliding = true
    end
end
