local Frame = BaseFrame:extend("TitleScreenFrame")

function Frame:create()
    self.bg = love.graphics.newImage("TitleScreen/Background.png")
    self.bg.alpha = 0
    
    Timer.tween(3, self.bg, { alpha = 1 })
    self:add(self.bg)

    self.logo = love.graphics.newImage("TitleScreen/Logo.png")
    self.logo.x = -self.logo.width
    self.logo.y = 15
    self:add(self.logo)

    Timer.tween(3, self.logo, { x = 120 })

    self.characters = love.graphics.newImage("TitleScreen/Characters.png")
    self.characters.y = self.characters.height+200
    self:add(self.characters)

    Timer.tween(3, self.characters, { y = 60 })
    
    self.button = love.graphics.newAnim("TitleScreen/ButtonFrames", 30, true)
    self.button.x = 800
    self.button.y = 400
    self:add(self.button)

    Timer.tween(2.9, self.button, { x = 250 })

    self.blackScreen = love.graphics.rectangle("fill", 0, 0, 800, 600)
    self.blackScreen.alpha = 0
    self.blackScreen.color = { 0, 0, 0 }
    self:add(self.blackScreen)

    TITLEMUSIC:play()
end

function Frame:mousepressed(x, y, button)
    if self.button:collision(x, y) then
        Timer.tween(1, self.blackScreen, { alpha = 1 }, "linear", function()
            switchFrame("FileSetup")
        end)
    end
end

return Frame