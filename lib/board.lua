local Board = Object:extend()

function Board:new(x, y, size)
    self.x = x
    self.y = y
    self.size = size

    self.color = Color(0.25, 0.25, 0.25)

    local map = {
        { 0, 0, 0, 0 },
        { 0, 0, 0, 0 },
        { 0, 0, 0, 0 },
        { 0, 0, 0, 0 },
    }

    self.map = {}

    for i, row in ipairs(map) do
        table.insert(self.map, {})
        for j, value in ipairs(row) do
            self:set_tile(i, j, Tile(value))
        end
    end

    for _ = 1, 2 do
        self:set_random_tile()
    end
end

function Board:draw()
    love.graphics.setColor(self.color.r, self.color.g, self.color.b, self.color.a)
    love.graphics.rectangle("fill", self.x - self.size / 2, self.y - self.size / 2, self.size, self.size)

    for _, row in ipairs(self.map) do
        for _, tile in ipairs(row) do
            tile:draw()
        end
    end
end

function Board:key_pressed(key)
    local num_rows = #self.map
    local num_columns = #self.map[1]
    local coords_list = {}

    local function insert_coords(coords)
        table.insert(coords_list, coords)
    end

    if key == "left" then
        for column = 1, num_columns do
            for row = 1, num_rows do
                insert_coords({ row = row, column = column })
            end
        end
    elseif key == "right" then
        for column = num_columns, 1, -1 do
            for row = 1, num_rows do
                insert_coords({ row = row, column = column })
            end
        end
    elseif key == "up" then
        for row = 1, num_rows do
            for column = 1, num_columns do
                insert_coords({ row = row, column = column })
            end
        end
    elseif key == "down" then
        for row = num_rows, 1, -1 do
            for column = 1, num_columns do
                insert_coords({ row = row, column = column })
            end
        end
    end

    local acted = self:slide_tiles(coords_list)

    if acted then
        self:set_random_tile()
    end
end

function Board:get_tile(row, column)
    return self.map[row][column]
end

function Board:set_tile(row, column, tile)
    tile.x = self.x - (3 / 8) * self.size + (column - 1) * self.size / 4
    tile.y = self.y - (3 / 8) * self.size + (row - 1) * self.size / 4
    tile.size = 0.9 * self.size / 4

    self.map[row][column] = tile
end

function Board:slide_tiles(coords_list)
    local acted = false
    for i, coords in ipairs(coords_list) do
        if i > 4 then
            if self:get_tile(coords_list[i - 4].row, coords_list[i - 4].column):get_value() == 0 then
                self:set_tile(coords_list[i - 4].row, coords_list[i - 4].column, self:get_tile(coords.row, coords.column))
                self:set_tile(coords.row, coords.column, Tile(0))
                acted = true
            elseif self:get_tile(coords.row, coords.column):get_value() == self:get_tile(coords_list[i - 4].row, coords_list[i - 4].column):get_value() then
                local value = self:get_tile(coords.row, coords.column):get_value() +
                    self:get_tile(coords_list[i - 4].row, coords_list[i - 4].column):get_value()
                self:set_tile(coords_list[i - 4].row, coords_list[i - 4].column, Tile(value))
                self:set_tile(coords.row, coords.column, Tile(0))
                acted = true
            end
        end
    end

    return acted
end

function Board:set_random_tile()
    local coordinates = self:get_random_empty_coordinates()
    local value = 2 * love.math.random(2)
    self:set_tile(coordinates.row, coordinates.column, Tile(value))
end

function Board:get_empty_coordinates()
    local coordinates_list = {}

    local num_rows = #self.map
    local num_columns = #self.map[1]

    for i = 1, num_rows do
        for j = 1, num_columns do
            if self:get_tile(i, j):get_value() == 0 then
                table.insert(coordinates_list, { row = i, column = j })
            end
        end
    end

    return coordinates_list
end

function Board:get_random_empty_coordinates()
    local empty_coordinates = self:get_empty_coordinates()
    local rand = love.math.random(#empty_coordinates)
    return empty_coordinates[rand]
end

return Board
