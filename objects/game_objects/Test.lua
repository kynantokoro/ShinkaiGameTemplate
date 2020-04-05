Test = Entity:extend()

function Test:new(area, x, y, opts)
    Test.super.new(self, area, x, y)
    local opts = opts or {}
    if opts then for k, v in pairs(opts) do self[k] = v end end

    self.image = love.graphics.newImage(self.image_path)
end 

function Test:update()
    
end 

function Test:draw()
    love.graphics.draw(self.image, self.x, self.y)
end 
