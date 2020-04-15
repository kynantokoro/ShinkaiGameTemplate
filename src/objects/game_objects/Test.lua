Test = Entity:extend()

function Test:new(area, x, y, animation_path, animation_tag)
    Test.super.new(self, area, x, y)
    self.x_offset = -16 
    self.y_offset = -16
    self.sprite = peachy.new(animation_path, animation_tag)
end 

function Test:update(dt)
    self.sprite:update(dt)
    if input:down("right") then self.x = self.x + 1 end 
    if input:down("left") then self.x = self.x - 1 end 
    if input:down("up") then self.y = self.y - 1 end 
    if input:down("down") then self.y = self.y + 1 end 
end 

function Test:draw()
    self.sprite:draw(self.x + self.x_offset, self.y + self.y_offset)
end 
