local Frame = BaseFrame:extend("fileSetupFrame")

function Frame:create()
    -- GENERAL OBJECTS
    self.currentInstance = "Files"
    self.currentFile = 1
    self.bg = love.graphics.newImage("FileSetup/Background.png")
    self:add(self.bg)

    self.buttonFlash = love.graphics.newAnim("FileSetup/ButtonFlashFrames", 30, true)
    self.buttonFlash.playing = false
    self.buttonFlash.visible = false

    -- END GENERAL OBJECTS

    -- FILES OBJECTS
    self.slot1 = love.graphics.newImage("FileSetup/Slot1.png")
    self.slot1.x = love.graphics.getWidth() / 2 - self.slot1.width / 2
    self.slot1.y = 100
    self:add(self.slot1)
    -- END FILES OBJECTS

    -- NEW/CONTINUE OBJECTS
    self.newGame = love.graphics.newImage("FileSetup/NewGame.png")
    self.newGame.x = love.graphics.getWidth() / 2 - self.newGame.width / 2
    self.newGame.y = 100
    self.continue = love.graphics.newImage("FileSetup/Continue.png") -- unused currently
    self.continue.x = love.graphics.getWidth() / 2 - self.continue.width / 2
    self.continue.y = 200

    self.newGame.visible = false
    self.continue.visible = false
    self:add(self.newGame)
    self:add(self.continue)
    -- END NEW/CONTINUE OBJECTS

    -- ERASE DATA OBJECTS
    self.yes = love.graphics.newImage("FileSetup/Yes.png")
    self.yes.x = love.graphics.getWidth() / 2 - self.yes.width / 2
    self.yes.y = 100
    self.yes.visible = false
    self.no = love.graphics.newImage("FileSetup/No.png")
    self.no.x = love.graphics.getWidth() / 2 - self.no.width / 2
    self.no.y = 200
    self.no.visible = false

    self:add(self.yes)
    self:add(self.no)
    -- END ERASE DATA OBJECTS

    -- GAME MODE OBJECTS
    self.adventure = love.graphics.newImage("FileSetup/Adventure.png")
    self.adventure.x = love.graphics.getWidth() / 2 - self.adventure.width / 2
    self.adventure.y = 100
    self.adventure.visible = false
    self.fixedParty = love.graphics.newImage("FileSetup/FixedParty.png")
    self.fixedParty.x = love.graphics.getWidth() / 2 - self.fixedParty.width / 2
    self.fixedParty.y = 200
    self.fixedParty.visible = false

    self:add(self.adventure)
    self:add(self.fixedParty)

    -- GAME MODE (2) OBJECTS
    self.normalMode = love.graphics.newImage("FileSetup/NormalMode.png")
    self.normalMode.x = love.graphics.getWidth() / 2 - self.normalMode.width / 2
    self.normalMode.y = 100
    self.normalMode.visible = false

    self.hardMode = love.graphics.newImage("FileSetup/HardMode.png")
    self.hardMode.x = love.graphics.getWidth() / 2 - self.hardMode.width / 2
    self.hardMode.y = 200
    self.hardMode.visible = false
    self:add(self.normalMode)
    self:add(self.hardMode)
    -- END GAME MODE (2) OBJECTS

    self:add(self.buttonFlash)
end

function Frame:mousepressed(x, y, button)
    if self.currentInstance == "Files" then
        if self.slot1:collision(x, y) then
            local midX, midY = self.slot1.x + self.slot1.width / 2, self.slot1.y + self.slot1.height / 2

            self.buttonFlash.x = midX - self.buttonFlash.images[1].width / 2
            self.buttonFlash.y = midY - self.buttonFlash.images[1].height / 2
            self.buttonFlash.playing = true
            self.buttonFlash.visible = true
            self.slot1.visible = false
            function self.buttonFlash.callback()
                self.buttonFlash.playing = false
                self.buttonFlash.visible = false

                self.currentInstance = "New/Continue"
                self.newGame.visible = true
                self.continue.visible = true
            end
        end
    elseif self.currentInstance == "New/Continue" then
        if self.newGame:collision(x, y) then
            local midX, midY = self.newGame.x + self.newGame.width / 2, self.newGame.y + self.newGame.height / 2

            self.buttonFlash.x = midX - self.buttonFlash.images[1].width / 2
            self.buttonFlash.y = midY - self.buttonFlash.images[1].height / 2
            self.buttonFlash.playing = true
            self.buttonFlash.visible = true
            self.newGame.visible = false
            function self.buttonFlash.callback()
                self.buttonFlash.playing = false
                self.buttonFlash.visible = false

                self.currentInstance = "Erase Data"
                self.newGame.visible = false
                self.continue.visible = false
                self.no.visible = true
                self.yes.visible = true
                self.normalMode.visible = false
            end
        elseif self.continue:collision(x, y) then
            local midX, midY = self.continue.x + self.continue.width / 2, self.continue.y + self.continue.height / 2

            self.buttonFlash.x = midX - self.buttonFlash.images[1].width / 2
            self.buttonFlash.y = midY - self.buttonFlash.images[1].height / 2
            self.buttonFlash.playing = true
            self.buttonFlash.visible = true
            self.continue.visible = false
            function self.buttonFlash.callback()
                self.buttonFlash.playing = false
                self.buttonFlash.visible = false

                self.newGame.visible = false
                self.continue.visible = false
                self.no.visible = true
            end
        end
    elseif self.currentInstance == "Erase Data" then
        if self.yes:collision(x, y) then
            local midX, midY = self.yes.x + self.yes.width / 2, self.yes.y + self.yes.height / 2

            self.buttonFlash.x = midX - self.buttonFlash.images[1].width / 2
            self.buttonFlash.y = midY - self.buttonFlash.images[1].height / 2
            self.buttonFlash.playing = true
            self.buttonFlash.visible = true
            self.yes.visible = false
            self.no.visible = false
            function self.buttonFlash.callback()
                self.buttonFlash.playing = false
                self.buttonFlash.visible = false

                self.currentInstance = "Game Mode"
                self.newGame.visible = false
                self.continue.visible = false
                self.no.visible = false
                self.yes.visible = false
                self.adventure.visible = true
                self.fixedParty.visible = true
            end
        elseif self.no:collision(x, y) then
            local midX, midY = self.no.x + self.no.width / 2, self.no.y + self.no.height / 2

            self.buttonFlash.x = midX - self.buttonFlash.images[1].width / 2
            self.buttonFlash.y = midY - self.buttonFlash.images[1].height / 2
            self.buttonFlash.playing = true
            self.buttonFlash.visible = true
            self.yes.visible = false
            self.no.visible = false
            function self.buttonFlash.callback()
                self.buttonFlash.playing = false
                self.buttonFlash.visible = false

                self.currentInstance = "Files"
                self.newGame.visible = true
                self.continue.visible = true
            end
        end
    elseif self.currentInstance == "Game Mode" then
        if self.normalMode:collision(x, y) then
            local midX, midY = self.normalMode.x + self.normalMode.width / 2, self.normalMode.y + self.normalMode.height / 2

            self.buttonFlash.x = midX - self.buttonFlash.images[1].width / 2
            self.buttonFlash.y = midY - self.buttonFlash.images[1].height / 2
            self.buttonFlash.playing = true
            self.buttonFlash.visible = true
            self.adventure.visible = false
            self.fixedParty.visible = false
            function self.buttonFlash.callback()
                self.buttonFlash.playing = false
                self.buttonFlash.visible = false

                self.currentInstance = "Game Mode (2)"
                self.normalMode.visible = true
                self.hardMode.visible = true
            end
        elseif self.hardMode:collision(x, y) then
            local midX, midY = self.hardMode.x + self.hardMode.width / 2, self.hardMode.y + self.hardMode.height / 2

            self.buttonFlash.x = midX - self.buttonFlash.images[1].width / 2
            self.buttonFlash.y = midY - self.buttonFlash.images[1].height / 2
            self.buttonFlash.playing = true
            self.buttonFlash.visible = true
            self.adventure.visible = false
            self.fixedParty.visible = false
            function self.buttonFlash.callback()
                self.buttonFlash.playing = false
                self.buttonFlash.visible = false

                self.currentInstance = "Game Mode (2)"
                self.normalMode.visible = true
                self.hardMode.visible = true
            end
        end
    elseif self.currentInstance == "Game Mode (2)" then
        if self.normalMode:collision(x, y) then
            local midX, midY = self.normalMode.x + self.normalMode.width / 2, self.normalMode.y + self.normalMode.height / 2

            self.buttonFlash.x = midX - self.buttonFlash.images[1].width / 2
            self.buttonFlash.y = midY - self.buttonFlash.images[1].height / 2
            self.buttonFlash.playing = true
            self.buttonFlash.visible = true
            self.normalMode.visible = false
            self.hardMode.visible = false
            function self.buttonFlash.callback()
                self.buttonFlash.playing = false
                self.buttonFlash.visible = false

                self.newGame.visible = true
                self.continue.visible = true

                switchFrame("CharacterSelect")
            end
        elseif self.hardMode:collision(x, y) then
            local midX, midY = self.hardMode.x + self.hardMode.width / 2, self.hardMode.y + self.hardMode.height / 2

            self.buttonFlash.x = midX - self.buttonFlash.images[1].width / 2
            self.buttonFlash.y = midY - self.buttonFlash.images[1].height / 2
            self.buttonFlash.playing = true
            self.buttonFlash.visible = true
            self.normalMode.visible = false
            self.hardMode.visible = false
            function self.buttonFlash.callback()
                self.buttonFlash.playing = false
                self.buttonFlash.visible = false

                self.newGame.visible = true
                self.continue.visible = true

                switchFrame("CharacterSelect")
            end
        end
    end
end

return Frame