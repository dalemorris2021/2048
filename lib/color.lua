local Color = Object:extend()

function Color:new(r, g, b, a)
    self.r = r
    self.g = g
    self.b = b
    self.a = a or 1
end

return Color
