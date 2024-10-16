-- Leave this at the top of the code
-- Provides actual debugging functionality
if arg[2] == "debug" then
    require("lldebugger").start()
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