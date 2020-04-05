MainMenu = Object:extend()

function MainMenu:new() 
    --initialize the room here!
    self.area = Area(self)
    self.area:addGameObject("Tilemap", 0, 0, "res/maps/tilemap_1")
    self.fireP = self.area:addGameObject("ParticleSystem", 0, 64, "res/particle.png", "FIRE")
end 

function MainMenu:update(dt) 
    self.area:update(dt)
end 

function MainMenu:draw() 
    self.area:draw()
    love.graphics.print("ROOM IS MAINMENU")
end 