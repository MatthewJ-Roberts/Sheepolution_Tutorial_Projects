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
    PosXRec = 0
    PosYRec = 0
    Move = true
    Mode = "fill"

    Words = { "LÖVE", "Gaming", "Creating" }
    WordsCycle = 1
    table.insert(Words, "Coding")
end

function love.update(dt)
    if PosX < 300 then
        PosX = PosX + 100 * dt
        PosY = PosY + 100 * dt
    else
        Move = false
    end

    -- Handle keyboard input for moving the rectangle
    -- Don't use elseif, otherwise diagonal movement doesn't work
    -- Ugly, but switch case statements aren't a thing, there is some kind of table approach though
    if love.keyboard.isDown("d") then
        PosXRec = PosXRec + 100 * dt
    end
    if love.keyboard.isDown("a") then
        PosXRec = PosXRec - 100 * dt
    end
    if love.keyboard.isDown("w") then
        PosYRec = PosYRec - 100 * dt
    end
    if love.keyboard.isDown("s") then
        PosYRec = PosYRec + 100 * dt
    end
end

function love.keypressed(key)
    if key == "space" then
        if Mode == "fill" then
            Mode = "line"
        else
            Mode = "fill"
        end
    elseif key == "tab" then
        if WordsCycle < #Words then
            WordsCycle = WordsCycle + 1
        else
            WordsCycle = 1
            if #Words > 1 then table.remove(Words, #Words - (#Words - 1)) end
        end
    elseif key == "lshift" then
        Words[1] = "You pressed lshift!"
    end
end

function love.draw()
    love.graphics.printf("Welcome to " .. Words[WordsCycle], 0, love.graphics.getHeight() / 2, love.graphics.getWidth(),
        "center")
    PrintSomeWords()
    love.graphics.rectangle(Mode, PosXRec, PosYRec, 100, 100)
    if Move then
        love.graphics.circle("line", PosX, PosY, 50, 50)
    else
        love.graphics.circle("fill", PosX, PosY, 50, 50)
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
