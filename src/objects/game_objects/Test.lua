Test = Entity:extend()

function Test:new(area, x, y, animation_path, animation_tag)
    Test.super.new(self, area, x, y)
    self.sprite = peachy.new(animation_path, animation_tag)
end 

function Test:update(dt)
    self.sprite:update(dt)
end 

function Test:draw()
    self.sprite:draw()
end 
