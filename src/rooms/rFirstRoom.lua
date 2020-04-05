FirstRoom = Object:extend()

function FirstRoom:new()
    consoleLine()
    print("FirstRoom:new()")

    --initialize the room here!
    self.area = Area(self)

    
    consoleLine() 
end 

function FirstRoom:update(dt) 
    self.area:update(dt)
end 

function FirstRoom:draw() 
    self.area:draw()
end 