local BaseFrame = Class:extend("BaseFrame")

function BaseFrame:new()
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

function BaseFrame:update(dt)
    for _, object in ipairs(self.objects) do
        if object.update then
            object:update(dt)
        end
    end
end

function BaseFrame:draw()
    for _, object in ipairs(self.objects) do
        if object.draw then
            object:draw()
        end
    end
end

return BaseFrame