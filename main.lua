push = require "push"
GAMEWIDTH = 320
GAMEHEIGHT = 256

function love.load() 
    --graphics initialization
    local windowWidth, windowHeight = love.graphics.getDimensions()
    love.graphics.setDefaultFilter("nearest")
    push:setupScreen(GAMEWIDTH, GAMEHEIGHT, windowWidth, windowHeight)
end 

function love.keypressed(key)
    if key == "escape" then
        love.event.quit()
    end
end

function love.resize(w, h)
    push:resize(w, h)
end

function love.update(dt)
    
end 

function love.draw() 
    
end 