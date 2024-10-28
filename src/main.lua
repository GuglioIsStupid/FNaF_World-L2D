Class = require("Lib.Class")
Timer = require("Lib.Timer")
require("Modules.Love.Graphics")
require("Modules.Love.Audio")

BaseFrame = require("Base.BaseFrame")

local FRAMETOSTART = "TitleScreen"

DIALOGUE_FONT = love.graphics.newFont("Assets/DOSFont.ttf", 20)
DIALOGUE_FONT:setFilter("nearest", "nearest")
love.graphics.setFont(DIALOGUE_FONT)

Frames = {
    TitleScreen = require("Frames.TitleScreen"),
    FileSetup = require("Frames.FileSetup"),
    CharacterSelect = require("Frames.CharacterSelect"),
    Cinematic = require("Frames.Cinematic"),
    Overworld = require("Frames.Overworld")
}

CURRENTFRAME = nil

TITLEMUSIC = love.audio.newSource("TitleTheme.mp3", "stream")
TITLEMUSIC:setLooping(true)
CINEMATICMUSIC = love.audio.newSource("Cinematic.mp3", "stream")
CINEMATICMUSIC:setLooping(true)

function switchFrame(frame, ...)
    if CURRENTFRAME and CURRENTFRAME.destroy then
        CURRENTFRAME:destroy(...)
    end
    CURRENTFRAME = Frames[frame]()
    CURRENTFRAME:create(...)
end

function love.load()
    switchFrame(FRAMETOSTART)
end

function love.update(dt)
    Timer.update(dt)
    if CURRENTFRAME and CURRENTFRAME.update then
        CURRENTFRAME:update(dt)
    end
end

function love.mousepressed(x, y, button)
    if CURRENTFRAME and CURRENTFRAME.mousepressed then
        CURRENTFRAME:mousepressed(x, y, button)
    end
end

function love.draw()
    if CURRENTFRAME and CURRENTFRAME.draw then
        CURRENTFRAME:draw()
    end
end