local Frame = BaseFrame:extend("CharacterSelectFrame")

function Frame:create()
    self.bg = love.graphics.newImage("CharacterSelect/Background.png")
    self:add(self.bg)
    -- 8 by 5 tile grid (PAIN) (8 width, 6 height)
    self.tiles = {}
    for x = 1, 8 do
        self.tiles[x] = {}
        for y = 1, 6 do
            local tileid = (y-1)*8+x+10
            self.tiles[x][y] = love.graphics.newImage("CharacterSelect/Tiles/Animation "..tileid.."/_0.png")
            self.tiles[x][y].x = (x-1)*(self.tiles[x][y].width+2) + 20
            self.tiles[x][y].y = (y-1)*(self.tiles[x][y].height+2) + 20
            self.tiles[x][y].visible = false
            self.tiles[x][y].tile = tileid - 10
            self:add(self.tiles[x][y])

            Timer.after(tileid*0.025, function()
                self.tiles[x][y].visible = true
            end)
        end
    end
    self.selected = {1, 2, 3, 4, 5, 6, 7, 8} -- By default, tiles 1-8 are selected

    self.gps = {}
    for i = 1, 8 do
        self.gps[i] = love.graphics.newAnim("CharacterSelect/G1P"..i, 30, true)
        self.gps[i].x = self.tiles[i][1].x
        self.gps[i].y = self.tiles[i][1].y
        self.gps[i].visible = false
        self:add(self.gps[i])
    end

    self.reset = love.graphics.newAnim("CharacterSelect/ResetButtonFrames", 30, true)
    self.reset.x = love.graphics.getWidth() - self.reset.images[1].width - 30
    self.reset.y = love.graphics.getHeight() - self.reset.images[1].height - 60
    self:add(self.reset)
    self.done = love.graphics.newAnim("CharacterSelect/DoneButtonFrames", 30, true)
    self.done.x = love.graphics.getWidth() - self.done.images[1].width - 30
    self.done.y = love.graphics.getHeight() - self.done.images[1].height - 20
    self:add(self.done)
end

function Frame:update(dt)
    BaseFrame.update(self, dt)
    -- update gps to new positions
    for i, gp in ipairs(self.gps) do
        gp.x = self.tiles[i][1].x
        gp.y = self.tiles[i][1].y
        gp.visible = self.tiles[i][1].visible
    end
end

function Frame:mousepressed(x, y, button)
    for i, tile in ipairs(self.tiles) do
        for j, t in ipairs(tile) do
            if t:collision(x, y) then
                if t.visible then
                    if self.selected[t.tile] then
                        self.selected[t.tile] = nil
                    else
                        self.selected[t.tile] = t.tile
                    end
                end
            end
        end
    end
    if self.reset:collision(x, y) then
        self.selected = {1, 2, 3, 4, 5, 6, 7, 8}
    end
    if self.done:collision(x, y) then
        --[[ Timer.tween(1, self.blackScreen, { alpha = 1 }, "linear", function()
            switchFrame("Cinematic")
        end) ]]
        switchFrame("Cinematic")
    end
end

return Frame