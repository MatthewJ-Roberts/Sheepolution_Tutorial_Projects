function CreateRect()
    local rect = {}
    rect.posX = 0
    rect.posY = 0
    rect.mode = "fill"
    rect.speed = 100
    rect.player = #Rectangles + 1
    table.insert(Rectangles, rect)
end

function MoveRectangles(dt)
    for i, rect in ipairs(Rectangles) do
        if rect.player == 1 then
            -- Handle keyboard input for moving the rectangle
            -- Don't use elseif, otherwise diagonal movement doesn't work
            -- Ugly, but switch case statements aren't a thing, there is some kind of table approach though
            if love.keyboard.isDown("d") then
                rect.posX = rect.posX + rect.speed * dt
            end
            if love.keyboard.isDown("a") then
                rect.posX = rect.posX - rect.speed * dt
            end
            if love.keyboard.isDown("w") then
                rect.posY = rect.posY - rect.speed * dt
            end
            if love.keyboard.isDown("s") then
                rect.posY = rect.posY + rect.speed * dt
            end
        else
            if love.keyboard.isDown("right") then
                rect.posX = rect.posX + rect.speed * dt
            end
            if love.keyboard.isDown("left") then
                rect.posX = rect.posX - rect.speed * dt
            end
            if love.keyboard.isDown("up") then
                rect.posY = rect.posY - rect.speed * dt
            end
            if love.keyboard.isDown("down") then
                rect.posY = rect.posY + rect.speed * dt
            end
        end
    end
end