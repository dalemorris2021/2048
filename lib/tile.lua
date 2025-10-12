local Tile = Object:extend()

function Tile:new(value, x, y, size)
    self.value = value
    self.x = x or 0
    self.y = y or 0
    self.size = size or 0
    self.color = self:get_color()

    local font = love.graphics.getFont()
    if value ~= 0 then
        self.text = love.graphics.newText(font, value)
    end
end

function Tile:draw()
    love.graphics.setColor(self.color.r, self.color.g, self.color.b, self.color.a)
    love.graphics.rectangle("fill", self.x - self.size / 2, self.y - self.size / 2, self.size, self.size)

    if self.value ~= 0 then
        love.graphics.setColor(1, 1, 1)
        love.graphics.draw(self.text, self.x, self.y, 0, self.size / 50, self.size / 50,
            self.text:getWidth() / 2, self.text:getHeight() / 2)
    end
end

function Tile:get_value()
    return self.value
end

function Tile:get_color()
    if self.value == 0 then
        return Color(0.5, 0.5, 0.7)
    end

    local r
    local g
    local b

    local function get_multiplier(magnitude)
        return (magnitude - 1) % 3 + 1
    end

    local magnitude = math.log(self.value, 2)
    if magnitude <= 3 then
        r = 0.3 * get_multiplier(magnitude)
        g = 0
        b = 0
    elseif magnitude <= 6 then
        r = 0
        g = 0.3 * get_multiplier(magnitude)
        b = 0
    elseif magnitude <= 9 then
        r = 0
        g = 0
        b = 0.3 * get_multiplier(magnitude)
    elseif magnitude <= 12 then
        r = 0
        g = 0.3 * get_multiplier(magnitude)
        b = 0.3 * get_multiplier(magnitude)
    elseif magnitude <= 15 then
        r = 0.3 * get_multiplier(magnitude)
        g = 0
        b = 0.3 * get_multiplier(magnitude)
    else
        r = 0.3 * get_multiplier(magnitude)
        g = 0.3 * get_multiplier(magnitude)
        b = 0
    end

    return Color(r, g, b)
end

return Tile
