Player = Entity:extend()

function Player:new(x, y)
    Player.super.new(self, x, y, "player.png")
    self.image = love.graphics.newImage("player.png")
    self.quad = love.graphics.newQuad(0, 0, 8, 8, self.image:getDimensions())
    self.facing = 1
    self.walk_spd = 1
    self.hsp = 0
    self.max_hsp = 2
    self.vsp = 0
    self.drag = 0.35
    self.hsp_decimal = 0
    self.vsp_decimal = 0
    self.jumps = 0
    self.jump_spd = -3.6
    self.jumps_initial = 3 
    self.states = {}
    local IDLE = {
        update = function(dt) 
            
            self:calculateMovement()

            if self.hsp ~= 0 then self.state = "WALK" end 
            
            --change to ducking image 
            if down then 
                self.quad = love.graphics.newQuad(8, 0, 8, 8, self.image:getWidth(), self.image:getHeight())
            else 
                self.quad = love.graphics.newQuad(0, 0, 8, 8, self.image:getWidth(), self.image:getHeight())
            end

            if jump then
                --jump on this frame and change state to "JUMP"
                self:jumped()
            end 

            self:Collisions()
        end,
        draw = function()
            love.graphics.draw(self.image, self.quad, self.x, self.y, 0, 1, self.image_yscale, 0, 0)
        end 
    }
    local WALK = {
        update = function(dt) 
            
            self:calculateMovement()

            if self.hsp == 0 then self.state = "IDLE" end

            if down then 
                self.quad = love.graphics.newQuad(8, 0, 8, 8, self.image:getWidth(), self.image:getHeight())
            else 
                self.quad = love.graphics.newQuad(0, 0, 8, 8, self.image:getWidth(), self.image:getHeight())
            end

            if jump then
                --jump on this frame and change state to "JUMP"
                self:jumped()
            end 

            self:Collisions()
        end,
        draw = function()
            love.graphics.draw(self.image, self.quad, self.x, self.y, 0, 1, self.image_yscale, 0, 0)
        end
    }
    local JUMP = {
        update = function(dt) 
            
            self:calculateMovement()

            if self.hsp ~= 0 then self.state = "WALK" else self.state = "IDLE" end

            if jump then self:jumped() end

            if down then 
                self.quad = love.graphics.newQuad(8, 0, 8, 8, self.image:getWidth(), self.image:getHeight())
            else 
                self.quad = love.graphics.newQuad(0, 0, 8, 8, self.image:getWidth(), self.image:getHeight())
            end

            self:Collisions()
        end,
        draw = function()
            love.graphics.draw(self.image, self.quad, self.x, self.y, 0, 1, self.image_yscale, 0, 0)
        end
    }
    self.states["IDLE"] = IDLE 
    self.states["WALK"] = WALK 
    self.states["JUMP"] = JUMP 
    self.state = "IDLE"
end 

function Player:update()
    self.states[self.state].update(dt)
end 

function Player:draw()
    self.states[self.state].draw()
end 

function Player:calculateMovement()
    
    local isDrag = false

    --calculate horizontal movement
    if left and right then 
        isDrag = true
    elseif left then 
        self.hsp = self.hsp - self.walk_spd
        isDrag = false 
    elseif right then 
        self.hsp = self.hsp + self.walk_spd
        isDrag = false 
    else 
        isDrag = true
    end 
    --apply gravity 
    self.vsp = self.vsp + GRAVITY 

    --stop if hsp is low
    if math.abs(self.hsp) <= 0.1 then self.hsp = 0 end 

    --drag the charactor (as if on ice)
    if isDrag == true then self.hsp = lerp(self.hsp, 0, self.drag) end 

    --calculate face
    if self.hsp ~= 0 then self.facing = sign(self.hsp) end 

    --limit speed 
    self.hsp  = math.min(math.abs(self.hsp), self.max_hsp) * self.facing
end 

function Player:Collisions() 
    --collisions!!
    if self.hsp == 0 then self.hsp_decimal = 0 end 
    if self.vsp == 0 then self.vsp_decimal = 0 end 

    --apply carried over decimals
    self.hsp = self.hsp + self.hsp_decimal
    self.vsp = self.vsp + self.vsp_decimal
    --floor decimals
    self.hsp_decimal = self.hsp - (math.floor(math.abs(self.hsp)) * sign(self.hsp))
    self.hsp = self.hsp - self.hsp_decimal
    self.vsp_decimal = self.vsp - (math.floor(math.abs(self.vsp)) * sign(self.vsp))
    self.vsp = self.vsp - self.vsp_decimal 

    --horizontal collisions
    local side
    if self.hsp > 0 then side = self.x + GRID else side = self.x end 
    --set collision points (top and bottom) 
    local t1 = tilemap:getAtPixel(side + self.hsp, self.y)
    local t2 = tilemap:getAtPixel(side + self.hsp, self.y+GRID)

    if t1 ~= 0 and t2 ~= 0 then 
        --collision found 
        if self.hsp > 0 then self.x = self.x - (self.x % GRID) + GRID - 1 + 0.51
        else self.x = self.x - (self.x % GRID) - (side - self.x) end 
        self.hsp = 0
    end 

    self.x = self.x + self.hsp

    --vertical collisions
    local side 
    if self.vsp > 0 then side = self.y + GRID else side = self.y  end 
    --set collision points(left and right)
    local t1 = tilemap:getAtPixel(self.x, side + self.vsp)
    local t2 = tilemap:getAtPixel(self.x+GRID, side + self.vsp)

    if t1 ~= 0 and t2 ~= 0 then 
        --collision found 
        if self.vsp > 0 then self.y = self.y - (self.y % GRID) + GRID - 1 + 0.51 end 
        self.vsp = 0
    end 

    self.y = self.y + self.vsp
end 

function Player:jumped()
    if self:onGround() then self.jumps = self.jumps_initial end
    
    if self.jumps > 0 then
        self.vsp_decimal = 0
        self.state = "JUMP"
        self.vsp = self.jump_spd
        self.jumps = self.jumps - 1
        jumpSound:play()
    end 
end 

function Player:onGround()
    local side = self.y + GRID 
    local t1 = tilemap:getAtPixel(self.x, side + 1)
    local t2 = tilemap:getAtPixel(self.x + GRID, side + 1)
    
    if t1 == 1 and t2 == 1 then 
        return true 
    else 
        return false 
    end 
end 