require("libs.vscode_debugging_support")
-- Declaring upvalues (values only accessible by functions in this file)
-- Global variables (variables starting with a capital letter) are accessible anywhere in ALL files
-- Caveat: Constructors for classes start with capital letters as well
local Rectangle, rectangles, Circle, circles
local words
local wordsCycle
local tick
local players
local image, imgWidth, imgHeight
local followCircle, mouseX, mouseY, angle, cos, sin

function love.load()
    -- Getting libraries
    require("libs.example")
    require("libs.aabb_collision_detection")
    print(require("libs.exampleReturn"))

    Circle = require("libs.circle")
    Rectangle = require("libs.rectangle")
    tick = require("libs.tick")

    print(Test)

    love.window.setTitle("Hello LÖVE")
    love.graphics.setNewFont(24)

    words = { "LÖVE", "Gaming", "Creating" }
    wordsCycle = 1
    table.insert(words, "Coding")

    rectangles = {}
    players = 1
    table.insert(rectangles, Rectangle(players))

    -- Seeding math.random so that the circle radius is actually random
    math.randomseed(os.time())
    circles = {}
    table.insert(circles, Circle())

    tick.recur(function()
        table.insert(circles, Circle())
    end, 2)

    image = love.graphics.newImage("img/Silent-Voice-Monochrome.png")
    imgWidth = image:getWidth()
    imgHeight = image:getHeight()
    print(imgWidth)
    print(imgHeight)

    followCircle = Circle(love.graphics.getWidth() / 2, love.graphics.getHeight() / 2)
end

function love.update(dt)
    tick.update(dt)

    for i, circ in ipairs(circles) do
        circ:move(dt)
    end
    for i, rect in ipairs(rectangles) do
        rect:move(dt)
    end
    CheckColliding(rectangles)

    mouseX, mouseY = love.mouse.getPosition()
    angle = math.atan2(mouseY - followCircle.y, mouseX - followCircle.x)
    cos = math.cos(angle)
    sin = math.sin(angle)
    if Pythagoras() < love.graphics.getWidth() / 4 then
        followCircle:move(dt, cos, sin)
    end
end

function love.draw()
    love.graphics.printf(
        "Welcome to " .. words[wordsCycle],
        0,
        love.graphics.getHeight() / 2,
        love.graphics.getWidth(),
        "center"
    )
    PrintSomeWords()

    for i, rect in ipairs(rectangles) do
        rect:draw()
    end
    for i, circ in ipairs(circles) do
        circ:draw()
    end

    love.graphics.draw(image, imgWidth * 0.1 / 2 + 300, imgHeight * 0.1 / 2, 0, 0.1, 0.1, imgWidth / 2, imgHeight / 2)

    followCircle:draw()
    love.graphics.line(followCircle.x, followCircle.y, mouseX, followCircle.y)
    love.graphics.line(followCircle.x, followCircle.y, followCircle.x, mouseY)
    love.graphics.line(followCircle.x, followCircle.y, mouseX, mouseY)
    print(angle)
    love.graphics.setColor(1, 0, 0)
    love.graphics.circle("line", followCircle.x, followCircle.y, love.graphics.getWidth() / 4)
    love.graphics.setColor(0, 0, 1)
    love.graphics.circle("line", followCircle.x, followCircle.y, Pythagoras())
    love.graphics.setColor(1, 1, 1)
end

function love.keypressed(key)
    for i, rect in ipairs(rectangles) do
        rect:changeSpeed(key)
        rect:changeMode(key)
    end
    if key == "tab" then
        if wordsCycle < #words then
            wordsCycle = wordsCycle + 1
        else
            wordsCycle = 1
            if #words > 1 then
                table.remove(words, #words - (#words - 1))
            end
        end
    elseif key == "lshift" then
        words[1] = "You pressed lshift!"
    elseif key == "lalt" and #rectangles < 3 then
        players = players + 1
        table.insert(rectangles, Rectangle(players))
        table.insert(words, "Player " .. #rectangles .. " has joined!")
    end
end

function PrintSomeWords()
    for i = 1, #words do
        love.graphics.print(words[i], 100, 100 + 50 * i)
    end
    for i, v in ipairs(words) do
        love.graphics.print(
            "key: " .. i .. "\t" .. "value: " .. v,
            love.graphics.getWidth() / 2,
            love.graphics.getHeight() / 2 + i * 50
        )
    end
end

function Pythagoras()
    local a = mouseX - followCircle.x
    local b = mouseY - followCircle.y
    local c = a ^ 2 + b ^ 2

    return math.sqrt(c)
end
