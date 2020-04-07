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

    camera = Camera(0, 0, GAMEWIDTH, GAMEHEIGHT)

    fnt = love.graphics.newFont("res/font/TimesNewPixel.fnt", "res/font/TimesNewPixel_0.png")
    love.graphics.setFont(fnt)

    print("graphics initialized")

end 

function inputInit() 
    input:bind("left", "left")
    input:bind("right", "right")
    input:bind("up", "up")
    input:bind("space", "jump")
    input:bind("down", "down")

    input:bind('f1', function()
        print("Before collection: " .. collectgarbage("count")/1024)
        collectgarbage()
        print("After collection: " .. collectgarbage("count")/1024)
        print("Object count: ")
        local counts = type_count()
        for k, v in pairs(counts) do print(k, v) end
        consoleLine() 
    end)

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

function count_all(f)
    local seen = {}
    local count_table
    count_table = function(t)
        if seen[t] then return end
            f(t)
	    seen[t] = true
	    for k,v in pairs(t) do
	        if type(v) == "table" then
		    count_table(v)
	        elseif type(v) == "userdata" then
		    f(v)
	        end
	end
    end
    count_table(_G)
end

function type_count()
    local counts = {}
    local enumerate = function (o)
        local t = type_name(o)
        counts[t] = (counts[t] or 0) + 1
    end
    count_all(enumerate)
    return counts
end

global_type_table = nil
function type_name(o)
    if global_type_table == nil then
        global_type_table = {}
            for k,v in pairs(_G) do
	        global_type_table[v] = k
	    end
	global_type_table[0] = "table"
    end
    return global_type_table[getmetatable(o) or 0] or "Unknown"
end