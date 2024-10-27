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
        setFilter = function(self, min, mag)
            self.img:setFilter(min, mag)
        end,
        collision = function(self, x, y, w, h)
            w, h = w or 1, h or 1
            return self.x < x + w and x < self.x + self.width and self.y < y + h and y < self.y + self.height
        end,
        draw = function(self)
            love.graphics.push()
            love.graphics.setColor(1, 1, 1, self.alpha)
            o_graphics_draw(self.img, self.x, self.y, self.angle, self.scale.x, self.scale.y)
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
        setFilter = function(self, min, mag)
            for _, img in ipairs(self.images) do
                img:setFilter(min, mag)
            end
        end,
        collision = function(self, x, y, w, h)
            w, h = w or 1, h or 1
            return self.x < x + w and x < self.x + self.images[1].width and self.y < y + h and y < self.y + self.images[1].height
        end,
        draw = function(self)
            love.graphics.push()
            love.graphics.setColor(1, 1, 1, self.alpha)
            love.graphics.draw(self.images[self.current], self.x, self.y, self.angle, self.scale.x, self.scale.y)
            love.graphics.pop()
        end,
        update = function(self, dt)
            self.unflooredCurrent = self.unflooredCurrent + self.fps * dt
            self.current = math.floor(self.unflooredCurrent)
            if self.current > #self.images then
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