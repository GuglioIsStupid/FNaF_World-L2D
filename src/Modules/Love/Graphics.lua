local o_graphics_newImage = love.graphics.newImage
local o_graphics_newQuad = love.graphics.newQuad
local o_graphics_draw = love.graphics.draw
--- @param path string
function love.graphics.newImage(path)
    path = "Assets/" .. path

    local img = o_graphics_newImage(path)
    return {
        img = img,
        x = 0,
        y = 0,
        scale = {x = 1, y = 1},
        angle = 0,
        width = img:getWidth(),
        height = img:getHeight(),
        alpha = 1,
        visible = true,
        setFilter = function(self, min, mag)
            self.img:setFilter(min, mag)
        end,
        collision = function(self, x, y, w, h)
            w, h = w or 1, h or 1
            return self.x < x + w and x < self.x + self.width and self.y < y + h and y < self.y + self.height
        end,
        draw = function(self, alpha)
            if not self.visible then return end
            local lastColor = {love.graphics.getColor()}
            love.graphics.push()
            love.graphics.setColor(lastColor[1], lastColor[2], lastColor[3], self.alpha * (alpha or 1))
            o_graphics_draw(self.img, self.x, self.y, self.angle, self.scale.x, self.scale.y)
            love.graphics.setColor(lastColor[1], lastColor[2], lastColor[3], lastColor[4])
            love.graphics.pop()
        end
    }
end

--- @param x number
--- @param y number
--- @param width number
--- @param height number
--- @param img table
function love.graphics.newQuad(x, y, width, height, img)
    return o_graphics_newQuad(x, y, width, height, img.width, img.height)
end

--- @param img table
--- @param x number
--- @param y number
--- @param angle number
--- @param scaleX number
--- @param scaleY number
function love.graphics.draw(img, x, y, angle, scaleX, scaleY)
    --[[ img.x, img.y, img.angle, img.scale.x, img.scale.y = x or img.x, y or img.y, angle or img.angle, scaleX or img.scale.x, scaleY or img.scale.y
    img:draw() ]]
    if type(img) == "table" then
        img.x, img.y, img.angle, img.scale.x, img.scale.y = x or img.x, y or img.y, angle or img.angle, scaleX or img.scale.x, scaleY or img.scale.y
        img:draw()
    else
        o_graphics_draw(img, x, y, angle, scaleX, scaleY)
    end
end

function love.graphics.newAnim(folder, fps, loops)
    -- folder full of images
    -- usually _0 -> _# where # is the number of images
    local images = {}
    local i = 0
    while true do
        print(folder .. "/_" .. i .. ".png")
        if love.filesystem.getInfo("Assets/" .. folder .. "/_" .. i .. ".png") then
            local img = love.graphics.newImage(folder .. "/_" .. i .. ".png")
            table.insert(images, img)
            i = i + 1
        else
            break
        end
    end

    return {
        images = images,
        current = 1,
        unflooredCurrent = 1,
        x = 0,
        y = 0,
        scale = {x = 1, y = 1},
        angle = 0,
        alpha = 1,
        fps = fps or 24,
        loops = loops or false,
        playing = true,
        visible = true,
        setFilter = function(self, min, mag)
            for _, img in ipairs(self.images) do
                img:setFilter(min, mag)
            end
        end,
        collision = function(self, x, y, w, h)
            w, h = w or 1, h or 1
            return self.x < x + w and x < self.x + self.images[1].width and self.y < y + h and y < self.y + self.images[1].height
        end,
        draw = function(self, alpha)
            if not self.visible then return end
            local lastColor = {love.graphics.getColor()}
            love.graphics.push()
            love.graphics.setColor(lastColor[1], lastColor[2], lastColor[3], self.alpha * (alpha or 1))
            love.graphics.draw(self.images[self.current], self.x, self.y, self.angle, self.scale.x, self.scale.y)
            love.graphics.setColor(lastColor[1], lastColor[2], lastColor[3], lastColor[4])
            love.graphics.pop()
        end,
        update = function(self, dt)
            if not self.playing then return end
            self.unflooredCurrent = self.unflooredCurrent + self.fps * dt
            self.current = math.floor(self.unflooredCurrent)
            if self.current > #self.images then
                local reset = false
                if self.callback then
                    reset = self.callback(self)
                    self.callback = nil
                end
                if reset then 
                    self.current = #self.images
                    self.unflooredCurrent = #self.images
                    self.playing = false

                    return
                end
                if self.loops then
                    self.current = 1
                    self.unflooredCurrent = 1
                else
                    self.current = #self.images
                    self.unflooredCurrent = #self.images
                end
            end
        end
    }
end

local o_graphics_rectangle = love.graphics.rectangle
function love.graphics.rectangle(mode, x, y, width, height, radius, segments)
    -- returns a table with the same properties as an image
    ---@diagnostic disable-next-line: redundant-return-value
    return {
        x = x,
        y = y,
        width = width,
        height = height,
        mode = mode,
        radius = radius,
        segments = segments,
        alpha = 1,
        color = {1, 1, 1},
        visible = true,
        draw = function(self, alpha)
            if not self.visible then return end
            love.graphics.push()
            local last = {love.graphics.getColor()}
            love.graphics.setColor(self.color[1], self.color[2], self.color[3], self.alpha * (alpha or 1))
            o_graphics_rectangle(self.mode, self.x, self.y, self.width, self.height, self.radius, self.segments)
            love.graphics.setColor(last[1], last[2], last[3], last[4])
            love.graphics.pop()
        end
    }
end