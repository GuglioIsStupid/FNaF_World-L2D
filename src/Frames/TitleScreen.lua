local Frame = BaseFrame:extend("TitleScreenFrame")

function Frame:create()
    BaseFrame.new(self)

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

    self.theme = love.audio.newSource("TitleTheme.mp3", "stream")
    self.theme:setLooping(true)
    self.theme:play()
end

function Frame:update(dt)
    BaseFrame.update(self, dt)
end

return Frame