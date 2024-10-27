local o_audio_newSource = love.audio.newSource

function love.audio.newSource(file, type)
    file = "Assets/Music/" .. file
    print(file)
    return o_audio_newSource(file, type)
end