Class = require("Lib.Class")
Timer = require("Lib.Timer")
require("Modules.Love.Graphics")
require("Modules.Love.Audio")

BaseFrame = require("Base.BaseFrame")

Frames = {
    TitleScreen = require("Frames.TitleScreen")
}

CURRENTFRAME = nil

function switchFrame(frame)
    if CURRENTFRAME and CURRENTFRAME.destroy then
        CURRENTFRAME:destroy()
    end
    CURRENTFRAME = Frames[frame]()
    CURRENTFRAME:create()
end

function love.load()
    switchFrame("TitleScreen")
end

function love.update(dt)
    Timer.update(dt)
    if CURRENTFRAME and CURRENTFRAME.update then
        CURRENTFRAME:update(dt)
    end
end

function love.draw()
    if CURRENTFRAME and CURRENTFRAME.draw then
        CURRENTFRAME:draw()
    end
end