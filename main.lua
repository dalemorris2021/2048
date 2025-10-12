local board
local score
local song

function love.load()
    Object = require("lib.classic")
    Color = require("lib.color")
    Tile = require("lib.tile")
    Board = require("lib.board")
    Score = require("lib.score")

    board = Board(love.graphics.getWidth() / 2, love.graphics.getHeight() / 2, 400)
    score = Score(love.graphics.getWidth() / 2, love.graphics.getHeight() / 8)

    song = love.audio.newSource("assets/rhythmmagnet.mp3", "stream")
    song:setLooping(true)
    song:play()
end

function love.update(dt)
    score:update(dt)
end

function love.draw()
    love.graphics.setBackgroundColor(255 / 255, 200 / 255, 84 / 255)

    board:draw()
    score:draw()
end

function love.keypressed(key)
    if key == "left" or key == "right" or key == "up" or key == "down" then
        board:key_pressed(key)
    end
end
