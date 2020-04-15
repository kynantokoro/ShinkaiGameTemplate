FirstRoom = Object:extend()

function FirstRoom:new()
    consoleLine()
    print("FirstRoom:new()")

    --initialize the room here!
    self.area = Area(self)
    
    self.area:addGameObject("Test", 32, 32, "res/sprite/FASTRUN.json", "FASTRUN")

    consoleLine() 
end 

function FirstRoom:update(dt) 
    self.area:update(dt)
    if input:pressed("left") then print("asd") end 
end 

function FirstRoom:draw() 

    camera:attach()

    self.area:draw()

    camera:detach()

    love.graphics.print("value")

end 