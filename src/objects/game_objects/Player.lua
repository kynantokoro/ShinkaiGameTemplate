Player = Entity:extend()

function Player:new(area, x, y, animation_path, animation_tag, collision_map)
    Player.super.new(self, area, x, y)

    self.sprite = peachy.new(animation_path, animation_tag)
    self.facing = 1
    self.walk_spd = 0.4
    self.hsp = 0
    self.max_hsp = 1
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

            --if self.hsp ~= 0 then self.state = "WALK" end 

            if input:pressed("jump") then
                
                --jump on this frame and change state to "JUMP"
                self:jumped()
            end 

            self:Collisions()

            self.sprite:update(dt)
        end,
        draw = function()
            self.sprite:draw(self.x, self.y)
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

            --if self.hsp ~= 0 then self.state = "WALK" else self.state = "IDLE" end

            if input:pressed("jump") then self:jumped() end

            self:Collisions()
        end,
        draw = function()
            self.sprite:draw(self.x, self.y)
        end
    }
    self.states["IDLE"] = IDLE 
    self.states["WALK"] = WALK 
    self.states["JUMP"] = JUMP 
    self.state = "IDLE"
end 

function Player:update(dt)
    self.states[self.state].update(dt)
    camera:follow(self.x+100, self.y)
    player_state = self.state
end 

function Player:draw()
    self.states[self.state].draw()
end 

function Player:calculateMovement()
    
    local isDrag = false

    --calculate horizontal movement
    if input:down("left") and input:down("right") then 
        isDrag = true
    elseif input:down("left") then 
        self.hsp = self.hsp - self.walk_spd
        isDrag = false 
    elseif input:down("right") then 
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
    local t1 = colmap:getAtPixel(side + self.hsp, self.y)
    local t2 = colmap:getAtPixel(side + self.hsp, self.y+GRID)
    local t3 = colmap:getAtPixel(side + self.hsp, self.y+(GRID/2))

    if t1 ~= 0 or t2 ~= 0 or t3 ~= 0 then 
        --collision found 
        if self.hsp > 0 then 
            if self.x % GRID ~= 0 then 
                self.x = self.x - (self.x % GRID) + GRID
                print(self.x)
            else 
                self.x = self.x
            print(self.x)
            end 
        else self.x = self.x - (self.x % GRID) - (side - self.x) end 
        self.hsp = 0
    end

    self.x = self.x + self.hsp

    --vertical collisions
    local side 
    if self.vsp > 0 then side = self.y + (GRID*2) else side = self.y  end 
    --set collision points(left and right)
    local t1 = colmap:getAtPixel(self.x, side + self.vsp)
    local t2 = colmap:getAtPixel(self.x+GRID, side + self.vsp)

    if t1 ~= 0 or t2 ~= 0 then 
        --collision found 
        if self.vsp > 0 then
            if self.y % GRID ~= 0 then 
                self.y = self.y - (self.y % GRID) + GRID
            else 
                self.y = self.y
            end 
        end 
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
    end 
end 

function Player:onGround()
    local side = self.y + (GRID*2) 
    local t1 = colmap:getAtPixel(self.x, side + 1)
    local t2 = colmap:getAtPixel(self.x + GRID, side + 1)
    
    if t1 ~= nil and t2 ~= nil then 
        return true 
    else 
        return false 
    end 
end 