Test = Entity:extend()

function Test:new(area, x, y, image_path)
    Test.super.new(self, area, x, y)
    self.image_path = image_path
    self.image = love.graphics.newImage(self.image_path)
end 

function Test:update()
    
end 

function Test:draw()
    love.graphics.draw(self.image, self.x, self.y)
end 
