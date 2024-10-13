-- Leave this at the top of the code
-- Provides actually debugging functionality
if arg[2] == "debug" then
    require("lldebugger").start()
end

function love.load()
    love.window.setTitle("Hello LÖVE")
    love.graphics.setNewFont(24)
    PosX = 0
    PosY = 0
end

function love.update(dt)
    print(dt)
    PosX = PosX + 100 * dt
    PosY = PosY + 100 * dt
end

function love.draw()
    love.graphics.printf("Welcome to LÖVE", 0, love.graphics.getHeight() / 2, love.graphics.getWidth(), "center")
    love.graphics.rectangle("fill", love.graphics.getWidth() / 2, love.graphics.getHeight() / 4, 100, 100)
    love.graphics.circle("fill", PosX, PosY, 50, 50)
    -- love.errorTest()
end

-- function love.errorTest()
--     local x = nil

--     local y = 10

--     y = y + x
-- end

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
