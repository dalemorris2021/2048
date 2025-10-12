local Score = Object:extend()

function Score:new(x, y)
    self.x = x
    self.y = y
    self.value = 0
    self.color = Color(1, 1, 1)
    self.text = love.graphics.newText(love.graphics.getFont())
end

function Score:update(dt)
    self.value = self.value + dt
    self.text:set(string.format("%d", math.floor(self.value)))
end

function Score:draw()
    love.graphics.setColor(self.color.r, self.color.g, self.color.b, self.color.a)
    love.graphics.draw(self.text, self.x, self.y, 0, 2, 2, self.text:getWidth() / 2, self.text:getHeight() / 2)
end

return Score
