local BaseFrame = Class:extend("BaseFrame")

function BaseFrame:new()
    self.objects = {}
    self.alpha = 1
end

function BaseFrame:clear()
    self.objects = {}
end

function BaseFrame:add(object)
    table.insert(self.objects, object)
end

function BaseFrame:remove(object)
    for i, obj in ipairs(self.objects) do
        if obj == object then
            table.remove(self.objects, i)
            break
        end
    end
end

function BaseFrame:create()
end

function BaseFrame:update(dt)
    for _, object in ipairs(self.objects) do
        if object.update then
            object:update(dt)
        end
    end
end

function BaseFrame:mousepressed(x, y, button)
    for _, object in ipairs(self.objects) do
        if object.mousepressed then
            object:mousepressed(x, y, button)
        end
    end
end

function BaseFrame:draw()
    for _, object in ipairs(self.objects) do
        if object.draw then
            object:draw(self.alpha)
        end
    end
end

return BaseFrame