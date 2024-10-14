-- Leave this at the top of the code
-- Provides actual debugging functionality
if arg[2] == "debug" then
    require("lldebugger").start()
end

local posX, posY, move
local rectangle, rectangles
local words
local wordsCycle
local tick

function love.load()
    -- Getting libraries
    require("libs.example")
    print(require("libs.exampleReturn"))
    require("libs.rectangle")
    rectangle = require("libs.rectangle")
    tick = require("libs.tick")

    print(Test)

    love.window.setTitle("Hello LÖVE")
    love.graphics.setNewFont(24)
    
    posX = 0
    posY = 0
    move = true

    words = { "LÖVE", "Gaming", "Creating" }
    wordsCycle = 1
    table.insert(words, "Coding")

    rectangles = {}
    table.insert(rectangles, rectangle.createRect())
end

function love.update(dt)
    if posX < 300 then
        posX = posX + 100 * dt
        posY = posY + 100 * dt
    else
        move = false
    end
    for i, rect in ipairs(rectangles) do
        rectangle.moveRectangles(dt, rect)
    end
end

function love.draw()
    love.graphics.printf("Welcome to " .. words[wordsCycle], 0, love.graphics.getHeight() / 2, love.graphics.getWidth(),
        "center")
    PrintSomeWords()
    for i, rect in ipairs(rectangles) do
        love.graphics.rectangle(rect.mode, rect.posX, rect.posY, 100, 100)
    end
    if move then
        love.graphics.circle("line", posX, posY, 50, 50)
    else
        love.graphics.circle("fill", posX, posY, 50, 50)
    end
end

function love.keypressed(key)
    for i, rect in ipairs(rectangles) do
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
        if wordsCycle < #words then
            wordsCycle = wordsCycle + 1
        else
            wordsCycle = 1
            if #words > 1 then table.remove(words, #words - (#words - 1)) end
        end
    elseif key == "lshift" then
        words[1] = "You pressed lshift!"
    elseif key == "rctrl" and #rectangles < 2 then
        table.insert(rectangles, rectangle.createRect())
        table.insert(words, "Player 2 has joined!")
    end
end

function PrintSomeWords()
    for i = 1, #words do
        love.graphics.print(words[i], 100, 100 + 50 * i)
    end
    for i, v in ipairs(words) do
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
