Tilemap = Object:extend()

function Tilemap:new(image_path, map_data) 
    self.image = love.graphics.newImage(image_path)
    self.width = self.image:getWidth()
    self.height = self.image:getHeight()
    self.map = map_data
    self.tiles = {}
    table.insert( self.tiles, love.graphics.newQuad(0, 0, GRID, GRID, GRID, GRID) )
end 

function Tilemap:update(dt)

end 

function Tilemap:draw()
    for i,row in ipairs(self.map) do
        for j,tile in ipairs(row) do
            if tile ~= 0 then
                --Draw the image with the correct quad
                love.graphics.draw(self.image, self.tiles[1], (j-1) * GRID, (i-1) * GRID)
            end 
        end
    end
end 

function Tilemap:getAtPixel(x, y)
    local tx = math.floor(x / GRID) + 1
    local ty = math.floor(y / GRID) + 1
    return self.map[ty][tx] 
end 