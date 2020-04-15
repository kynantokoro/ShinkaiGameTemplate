function love.load()
    consoleLine() 
    print("love.load()")

    --import libraries and CONSTANTS
    require "src/import"

    graphicsInit()

    inputInit()

    audioInit()

    --global timer 
    t = 0

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
    
    --increment global timer 
    t = t + 1

    if current_room then current_room:update(dt) end 
    vEffect.pixelate.size = {0.0001+math.sin(t)*0.14, 0.0001+math.sin(t)*0.14}
end 

function love.draw() 
    love.graphics.setCanvas(vCanvas)
    vEffect(function()
        love.graphics.setColor(1, 1, 1, 0.1)
        love.graphics.rectangle("fill", 0, 0, GAMEWIDTH, GAMEHEIGHT)
        love.graphics.setColor(1, 1, 1, 1)
        -------------GAME------------

        --draw things on the virtual canvas
        if current_room then current_room:draw() end 

        -------------GAME------------
    end)
    love.graphics.setCanvas()
    cEffect(function()
        --scale the vCanvas
        love.graphics.push()
        love.graphics.scale(GAMEZOOM, GAMEZOOM)
        --draw the vCanvas
        --set the x_scale to 2 if mood is ATARI
        love.graphics.draw(vCanvas, 0, 0, 0, 1, 1)
        love.graphics.pop()
    end)
    -------------GUI------------

    love.graphics.print(love.timer.getFPS())

    -------------GUI------------

end 

function graphicsInit()
    --shaders initialize 
    cEffect = moonshine(GAMEWIDTH*GAMEZOOM, GAMEHEIGHT*GAMEZOOM, moonshine.effects.chromasep).chain(moonshine.effects.crt).chain(moonshine.effects.fastgaussianblur)
    vEffect = moonshine(GAMEWIDTH, GAMEHEIGHT, moonshine.effects.pixelate)
    cEffect.fastgaussianblur.sigma = -1
    cEffect.crt.scaleFactor = {0.93, 0.93}
    cEffect.chromasep.radius = 1

    --graphics initialization

    love.graphics.setDefaultFilter("nearest")

    camera = Camera(0, 0, GAMEWIDTH, GAMEHEIGHT)

    vCanvas = love.graphics.newCanvas(GAMEWIDTH, GAMEHEIGHT)

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

function audioInit() 
    love.audio.setEffect("myReverb", {type = "reverb", gain = 0.5, density = 1, decaytime = 1})
    snd_noise = love.audio.newSource("res/tracker/gamenoise.it", "stream")
    snd_noise:setEffect("myReverb")

    love.audio.play(snd_noise)
    love.audio.setVolume(0.8)
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