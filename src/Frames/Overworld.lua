local Frame = BaseFrame:extend("OverworldFrame")

function Frame:create()
    self.mapArea = require("Assets.Data.Overworld.MapData")

    self.freddy = {
        x = 1804,
        y = 1001,
    }
    self.freddy.idle = love.graphics.newImage("Overworld/FreddyWorld/Animation 0/_0.png")
    self.freddy.right = love.graphics.newAnim("Overworld/FreddyWorld/Direction 0", 30, true)
    self.freddy.left = love.graphics.newAnim("Overworld/FreddyWorld/Direction 16", 30, true)
    self.freddy.up = love.graphics.newAnim("Overworld/FreddyWorld/Direction 8", 30, true)
    self.freddy.down = love.graphics.newAnim("Overworld/FreddyWorld/Direction 24", 30, true)

    self.freddy.left.visible = false
    self.freddy.up.visible = false
    self.freddy.down.visible = false
    self.freddy.right.visible = false

    self.camera = {
        x = 0,
        y = 0,
    }

    for _, object in ipairs(self.mapArea) do
        self:add(object)
    end

    self:add(self.freddy.idle)
    self:add(self.freddy.right)
    self:add(self.freddy.left)
    self:add(self.freddy.up)
    self:add(self.freddy.down)
end

function Frame:update(dt)
    BaseFrame.update(self, dt)

    local speed = 120
    if love.keyboard.isDown("right", "d") then
        self.freddy.right.visible = true
        self.freddy.left.visible = false
        self.freddy.up.visible = false
        self.freddy.down.visible = false
        self.freddy.idle.visible = false
    elseif love.keyboard.isDown("left", "a") then
        self.freddy.right.visible = false
        self.freddy.left.visible = true
        self.freddy.up.visible = false
        self.freddy.down.visible = false
        self.freddy.idle.visible = false
    elseif love.keyboard.isDown("up", "w") then
        self.freddy.right.visible = false
        self.freddy.left.visible = false
        self.freddy.up.visible = true
        self.freddy.down.visible = false
        self.freddy.idle.visible = false
    elseif love.keyboard.isDown("down", "s") then
        self.freddy.right.visible = false
        self.freddy.left.visible = false
        self.freddy.up.visible = false
        self.freddy.down.visible = true
        self.freddy.idle.visible = false
    else
        self.freddy.right.visible = false
        self.freddy.left.visible = false
        self.freddy.up.visible = false
        self.freddy.down.visible = false
        self.freddy.idle.visible = true
    end

    local sign = love.keyboard.isDown("right", "d") and 1 or love.keyboard.isDown("left", "a") and -1 or 0
    self.freddy.x = self.freddy.x + speed * sign * dt
    sign = love.keyboard.isDown("down", "s") and 1 or love.keyboard.isDown("up", "w") and -1 or 0
    self.freddy.y = self.freddy.y + speed * sign * dt

    for _, anim in pairs(self.freddy) do
        if type(anim) == "table" then
            anim.x = self.freddy.x
            anim.y = self.freddy.y
        end
    end

    self.camera.x = self.freddy.x - love.graphics.getWidth()/2 + self.freddy.idle.width/2
    self.camera.y = self.freddy.y - love.graphics.getHeight()/2 + self.freddy.idle.height/2

    -- change all objects camera position
    for _, object in ipairs(self.objects) do
        object.camera = self.camera
    end
end

return Frame