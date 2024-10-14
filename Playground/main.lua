-- Leave this at the top of the code
-- Provides actual debugging functionality
if arg[2] == "debug" then
    require("lldebugger").start()
end

function love.load()
    love.window.setTitle("Hello LÖVE")
    love.graphics.setNewFont(24)
    
    PosX = 0
    PosY = 0
    Move = true

    Words = { "LÖVE", "Gaming", "Creating" }
    WordsCycle = 1
    table.insert(Words, "Coding")

    Rectangles = {}
    CreateRect()
end

function love.update(dt)
    if PosX < 300 then
        PosX = PosX + 100 * dt
        PosY = PosY + 100 * dt
    else
        Move = false
    end
    MoveRectangles(dt)
end

function love.draw()
    love.graphics.printf("Welcome to " .. Words[WordsCycle], 0, love.graphics.getHeight() / 2, love.graphics.getWidth(),
        "center")
    PrintSomeWords()
    for i, rect in ipairs(Rectangles) do
        love.graphics.rectangle(rect.mode, rect.posX, rect.posY, 100, 100)
    end
    if Move then
        love.graphics.circle("line", PosX, PosY, 50, 50)
    else
        love.graphics.circle("fill", PosX, PosY, 50, 50)
    end
end

function love.keypressed(key)
    for i, rect in ipairs(Rectangles) do
        if rect.player == 1 then
            if key == "space" then
                if rect.mode == "fill" then
                    rect.mode = "line"
                else
                    rect.mode = "fill"
                end
            elseif key == "lctrl" then
                if rect.speed < 500 then
                    rect.speed = rect.speed + 100
                else
                    rect.speed = 100
                end
            end
        else
            if key == "m" then
                if rect.mode == "fill" then
                    rect.mode = "line"
                else
                    rect.mode = "fill"
                end
            elseif key == "," then
                if rect.speed < 500 then
                    rect.speed = rect.speed + 100
                else
                    rect.speed = 100
                end
            end
        end
    end
    if key == "tab" then
        if WordsCycle < #Words then
            WordsCycle = WordsCycle + 1
        else
            WordsCycle = 1
            if #Words > 1 then table.remove(Words, #Words - (#Words - 1)) end
        end
    elseif key == "lshift" then
        Words[1] = "You pressed lshift!"
    elseif key == "rctrl" and #Rectangles < 2 then
        CreateRect()
        table.insert(Words, "Player 2 has joined!")
    end
end

function PrintSomeWords()
    for i = 1, #Words do
        love.graphics.print(Words[i], 100, 100 + 50 * i)
    end
    for i, v in ipairs(Words) do
        love.graphics.print("key: " .. i .. "\t" .. "value: " .. v, love.graphics.getWidth() / 2,
            love.graphics.getHeight() / 2 + i * 50)
    end
end

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

-- Leave this at the bottom of the code
-- Provides improved VSCode debugging info
local love_errorhandler = love.errorhandler

function love.errorhandler(msg)
    if "lldebugger" then
        error(msg, 2)
    else
        return love_errorhandler(msg)
    end
end
