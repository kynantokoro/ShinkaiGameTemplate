require "src/import"

function love.load()
    graphicsInit()
end 

function love.keypressed(key)
    if key == "escape" then
        love.event.quit()
    end
end

function love.keyreleased(key)
    --capture the up release to enable jump toggle 
    if key == "up" then 
        up_pressed = false 
    end 
end

function love.resize(w, h)
    push:resize(w, h)
end

function love.update(dt)
    --get keyboard input every frame
    getInput()
end 

function love.draw() 
    push:start()

    push:finish()
    love.graphics.print(love.timer.getFPS())
end 

function graphicsInit()
    --graphics initialization
    local windowWidth, windowHeight = love.graphics.getDimensions()
    love.graphics.setDefaultFilter("nearest")
    push:setupScreen(GAMEWIDTH, GAMEHEIGHT, windowWidth, windowHeight)
end 

function getInput() 
    left = love.keyboard.isDown("left")
    right = love.keyboard.isDown("right")
    up = love.keyboard.isDown("up")
    --store boolean in up_pressed and only trigger jump when up is just pressed 
    if up and up_pressed then jump = false elseif up then up_pressed = true jump = true end 
    down = love.keyboard.isDown("down")
end