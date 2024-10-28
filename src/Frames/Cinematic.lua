local Frame = BaseFrame:extend("CinematicFrame")

function Frame:create()
    TITLEMUSIC:stop()
    CINEMATICMUSIC:play()

    self.bg = love.graphics.newImage("Cinematic/Backgrounds/background_0-0_0.png")
    self:add(self.bg)
    self.cinematic = 1
    self.curDialogue = 1

    self.cinematicDialogues = {
        {
            "I know you may feel like going out and taking a stroll, but something seems very wrong today.",
            "All is NOT well in Animatronica. Animatronic Village? Village-tronica? (We are working on it.) The point is that something is horribly wrong!",
            "There have been a lot of bizarre creatures roaming around lately, even some that look like... *gulp*  ...us.",
            "We aren't prepared to deal with situations like this. Something bad must have happened on the flipside.",
            "Go see what you can find. Be careful though, our wood-cutting Auto-Chipper has gone haywire! It has been jumpscaring me all day!"
        }
    }

    self.textBox = love.graphics.newAnim("Cinematic/TextBoxFrames", 30, true)
    self.textBox.x = love.graphics.getWidth()/2 - self.textBox.images[1].width/2
    self.textBox.y = 5
    function self.textBox.callback()
        self.textBox.playing = false
        self.showDialogue = true
        Timer.after(0.75, function()
            self.next.visible = true
        end)
        return true
    end

    self.next = love.graphics.newAnim("Cinematic/NextFrames", 30, true)
    self.next.x = self.textBox.x + self.textBox.images[1].width/2 - self.next.images[1].width/2
    self.next.y = self.textBox.y + self.textBox.images[1].height - 55
    self.next.visible = false

    self.done = love.graphics.newAnim("CharacterSelect/DoneButtonFrames", 30, true)
    self.done.x = self.textBox.x + self.textBox.images[1].width/2 - self.done.images[1].width/2
    self.done.y = self.textBox.y + self.textBox.images[1].height - 55
    self.done.visible = false

    self.showDialogue = false

    self:add(self.textBox)
    self:add(self.next)
    self:add(self.done)

    self.fredbear = love.graphics.newAnim("CharacterSelect/Shopkeeper/Animation 0", 30, true)
    self.fredbear.x = 60
    self.fredbear.y = love.graphics.getHeight() - self.fredbear.images[1].height
    self:add(self.fredbear)

    self.freddy = love.graphics.newAnim("CharacterSelect/Characters/Animation 11", 30, true)
    self.freddy.x = love.graphics.getWidth() - self.freddy.images[1].width - 60 + 300
    self.freddy.y = love.graphics.getHeight() - self.freddy.images[1].height - 150
    self:add(self.freddy)

    -- tween freddy to the correct position
    Timer.tween(0.3, self.freddy, { x = love.graphics.getWidth() - self.freddy.images[1].width - 60, y = love.graphics.getHeight() - self.freddy.images[1].height }, "linear")
end

function Frame:update(dt)
    BaseFrame.update(self, dt)
end

function Frame:mousepressed(x, y, button)
    if self.next.visible then
        self.curDialogue = self.curDialogue + 1
        self.next.visible = false
        self.textBox.playing = true
        self.textBox.current = 1
        self.textBox.unflooredCurrent = 1
        self.showDialogue = false
        function self.textBox.callback()
            self.textBox.playing = true
            self.showDialogue = true
            Timer.after(0.75, function()
                --[[ self.next.visible = true ]]
                if self.curDialogue == #self.cinematicDialogues[self.cinematic] then
                    self.done.visible = true
                else
                    self.next.visible = true
                end
            end)
            return true
        end
    end

    if self.done:collision(x, y) and self.done.visible then
        self.done.visible = false
        self.next.visible = false
        self.showDialogue = false
        switchFrame("Overworld")
    end
end

function Frame:draw()
    BaseFrame.draw(self)

    if self.showDialogue then
        love.graphics.printf(self.cinematicDialogues[self.cinematic][self.curDialogue], self.textBox.x+50, self.textBox.y+20, self.textBox.images[1].width-100, "left")
    end
end

return Frame