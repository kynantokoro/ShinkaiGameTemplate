--all dynamic class extends this class 
--which are player, enemy, item, anything with a position within the world

Entity = Object:extend()

function Entity:new(x, y, image_path)
    self.x = x 
    self.y = y 
    self.image = love.graphics.newImage(image_path)
    self.image_xscale = 1;
    self.image_yscale = 1;
    self.width = self.image:getWidth()
    self.height = self.image:getHeight()
end 

function Entity:update()
    
end 

function Entity:draw()
    love.graphics.draw(self.image, self.x, self.y, 0, self.image_xscale, self.image_yscale)
end 