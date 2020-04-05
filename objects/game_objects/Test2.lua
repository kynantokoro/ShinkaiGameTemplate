Test2 = Entity:extend()

function Test2:new(area, x, y, opts)--image_path
    Test.super.new(self, area, x, y)
    local opts = opts or {}
    if opts then for k, v in pairs(opts) do self[k] = v end end

    self.image = love.graphics.newImage(self.image_path)
end 

function Test2:update()
    
end 

function Test2:draw()
    love.graphics.setColor(1, 0, 0)
    love.graphics.draw(self.image, self.x, self.y)
    love.graphics.setColor(1, 1, 1)
end 
