--Base class for any kind of particle effects (fire, trail, etc..)

ParticleSystem = Entity:extend()

function ParticleSystem:new(area, x, y, image_path, preset_name) 
    ParticleSystem.super.new(self, area, x, y)
    self.inix = self.x 
    self.iniy = self.y
    self.image = love.graphics.newImage(image_path)
    self.presets = {}
    local FIRE = {
        init = function ()
            local particleTexture = self.image
            local quads = {}

            for i=1, particleTexture:getWidth()/GRID do 
                quads[i] = love.graphics.newQuad(GRID*(i-1), 0, GRID, GRID, particleTexture:getDimensions())
            end 

            psystem = love.graphics.newParticleSystem(particleTexture, 128)
            psystem:setQuads(quads[1], quads[2], quads[3], quads[4], quads[5])
            psystem:setParticleLifetime(1, 2) --Particles live at least 2d and 
            psystem:setEmissionRate(100)
            psystem:setDirection(1)
            psystem:setEmissionArea("normal", 0.3, 0.3)
            psystem:setSizeVariation(0)
            psystem:setSpin(0.1)
            psystem:setLinearAcceleration(-3, -60, 3, -50) -- Random movement in all directions. 
            psystem:setColors(1, 1, 1, 1, 1, 0.6, 0.6, 0.4) -- fade to transparant
        end,
        update = function (dt) 
            if input:down("right") then self.x = self.x+1 elseif input:down("left") then self.x = self.x-1 end 
            psystem:update(dt)
            psystem:setPosition( self.x, self.y)
            if input:down("jump") then  psystem:start() else psystem:stop() end  
        end, 
        draw = function () 
            love.graphics.draw(psystem)
        end 
    }
    self.preset = preset_name
    self.presets["FIRE"] = FIRE
    self.presets[self.preset].init()
end 

function ParticleSystem:update(dt)
    self.presets[self.preset].update(dt)
end 

function ParticleSystem:draw()
    self.presets[self.preset].draw()
end
