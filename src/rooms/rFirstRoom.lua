FirstRoom = Object:extend()

function FirstRoom:new()

    print("FirstRoom:new()")

    --initialize the room here!
    self.area = Area(self)
    
    self.tilemap = Tilemap(self.area, 0, 0, "res/maps/tilemap_1")

    print("tilemaploaded")

    self.player = self.area:addGameObject("Test", GAMEWIDTH/2, GAMEHEIGHT/2, "res/sprite/FASTRUN.json", "FASTRUN")

    self.particle = self.area:addGameObject("ParticleSystem", GAMEWIDTH/2, GAMEHEIGHT/2, "res/FX/particle.png", "FIRE")

end 

function FirstRoom:update(dt) 
    self.area:update(dt)
    camera:update(dt)
    camera:follow(self.player.x, self.player.y)
end 

function FirstRoom:draw() 

    camera:attach()
    
    self.area:draw()

    self.tilemap:draw()

    camera:detach()

    love.graphics.print("value")

end 