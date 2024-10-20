require("libs.vscode_debugging_support")

local Image
local sprites, playerImage, player, enemyImage, enemy
local bullets, score, highScore
local json

function love.load()
    -- Getting libraries
    require("libs.aabb_collision_detection")
    Image = require("libs.image")
    Rectangle = require("libs.rectangle")
    json = require("libs.json")

    -- Seeding math.random so that the circle radius is actually random
    math.randomseed(os.time())

    -- Making font readable
    love.graphics.setNewFont(24)

    score = 0
    bullets = {}

    CreateCharacters()
    GenerateBackground()

    if not LoadData() then
        highScore = 0
    end
end

function love.update(dt)
    player:movePlayer(dt)
    enemy:moveEnemy(dt)

    for i, bullet in ipairs(bullets) do
        if not bullet:move(dt) then
            if score > highScore then
                highScore = score
            end
            SaveData()
            love.load()
        end
        if AabbFormula(enemy, bullet) then
            enemy:increaseSpeed(dt)
            table.remove(bullets, i)
            score = score + 1
        end
    end
end

function love.draw()
    player:draw()
    enemy:draw()
    for i, bullet in ipairs(bullets) do
        bullet:draw()
    end
    love.graphics.print("High Score: " .. highScore, 5, player.height)
    love.graphics.print("Score: " .. score, 5, player.height + 29)
end

function love.keypressed(key)
    if key == "space" then
        table.insert(
            bullets,
            Rectangle(player.posX + (player.width / 2), player.posY + player.height, player.bulletColor)
        )
    end
end

function love.quit()
    SaveData()
end

function GenerateBackground()
    -- Generate a muted random color
    local mutedFactor = 0.5 -- Controls how muted the colors are (0 = grayscale, 1 = full color)
    local baseColor = 0.5 -- Controls how bright/dark the colors are (0 = black, 1 = white)

    local r = baseColor + math.random() * mutedFactor - mutedFactor / 2
    local g = baseColor + math.random() * mutedFactor - mutedFactor / 2
    local b = baseColor + math.random() * mutedFactor - mutedFactor / 2

    love.graphics.setBackgroundColor(r, g, b)
end

function CreateCharacters()
    -- Creating player and enemy
    sprites = love.filesystem.getDirectoryItems("img/50+ Monsters Pack 2D/Monsters/Normal Colors")
    playerImage =
        love.graphics.newImage("img/50+ Monsters Pack 2D/Monsters/Normal Colors/" .. sprites[math.random(1, #sprites)])
    enemyImage =
        love.graphics.newImage("img/50+ Monsters Pack 2D/Monsters/Normal Colors/" .. sprites[math.random(1, #sprites)])
    player = Image(playerImage, 0, 500)
    enemy = Image(enemyImage, love.graphics.getHeight() - enemyImage:getWidth(), 50)
end

function SaveData()
    -- Writes to here: C:\Users\<YourUsername>\AppData\Roaming\LOVE\<YourGameName>\
    love.filesystem.write("savedata.json", json.encode(highScore))
end

function LoadData()
    if love.filesystem.getInfo("savedata.json") then
        highScore = json.decode(love.filesystem.read("savedata.json"))
        return true
    end
    print("Failed to find save data")
    return false
end
