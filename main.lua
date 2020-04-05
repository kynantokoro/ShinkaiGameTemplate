function love.load()
    consoleLine() 
    print("love.load()")

    --import libraries and CONSTANTS
    require "src/import"

    graphicsInit()

    inputInit()

    current_room = nil

    --load objects
    local object_files = {}
    recureiveEnumerate("src/objects", object_files)
    requireFiles(object_files)

    --load rooms
    local room_files = {}
    recureiveEnumerate("src/rooms", room_files)
    requireFiles(room_files)

    gotoRoom("FirstRoom")
    consoleLine() 
end

function love.update(dt)

    if current_room then current_room:update(dt) end 

end 

function love.draw() 

    push:start()

        if current_room then current_room:draw() end 

    push:finish()

    love.graphics.print(love.timer.getFPS())
end 

function graphicsInit()

    --graphics initialization
    local windowWidth, windowHeight = love.graphics.getDimensions()

    love.graphics.setDefaultFilter("nearest")

    push:setupScreen(GAMEWIDTH, GAMEHEIGHT, windowWidth, windowHeight)

    print("graphics initialized")

end 

function inputInit() 
    input:bind("left", "left")
    input:bind("right", "right")
    input:bind("up", "up")
    input:bind("space", "jump")
    input:bind("down", "down")

    print("input initialized")

end

--this function loops throgh item in a folder and list it in a table
function recureiveEnumerate(folder, file_list) 
    local items = love.filesystem.getDirectoryItems(folder) 
    for _, item in ipairs(items) do 
        local file_path = folder .. "/" .. item
        local file_info = love.filesystem.getInfo(file_path)
        if file_info.type == "file" then 
            table.insert(file_list, file_path) 
            --also checks if the file is a directory and if so loops through in that too
        elseif file_info.type == "directory" then 
            recureiveEnumerate(file_path, file_list) 
        end 
    end 
end 

--loop through a list and require those file
function requireFiles(files)
    for _, file in ipairs(files) do
        print("loaded :" .. file)
        local file = file:sub(1, -5)
        require(file)
    end
end

function gotoRoom(room_type, ...)
    print("current_room is :" ..  room_type)
    current_room = _G[room_type](...)
end 


function love.resize(w, h)
    push:resize(w, h)
    print("resized " .. " w : " .. w .. " h : " .. h)
end

function love.keyreleased(key) 
    if key == "escape" then 
        love.event.quit()
    end 
end 

function consoleLine() 
    print("--------------------------")
end 