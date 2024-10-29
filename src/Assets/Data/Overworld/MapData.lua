local backdrop = Class:extend("Backdrop")

function backdrop:new(startX, startY, endX, endY, img)
    self.startX = startX
    self.startY = startY
    self.endX = endX
    self.endY = endY
    self.img = img
    self.camera = nil
end

function backdrop:draw()
    love.graphics.push()
    if self.camera then
        love.graphics.translate(-self.camera.x, -self.camera.y)
    end
    for x = self.startX, self.endX, self.img:getWidth() do
        for y = self.startY, self.endY, self.img:getHeight() do
            love.graphics.baseDraw(self.img, x, y)
        end
    end
    love.graphics.pop()
end

local grassArea = backdrop(824, 69, 2034, 2025, love.graphics.baseNewImage("Assets/Overworld/Grass.png"))
local snowArea = backdrop(-100, 700, 1057, 1400, love.graphics.baseNewImage("Assets/Overworld/Snow.png"))

local map = {}
table.insert(map, grassArea)
table.insert(map, snowArea)

return map