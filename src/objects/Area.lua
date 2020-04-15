--instantiate ONE per room
--manages all entities update, draw, add, remove, within a room 

Area = Object:extend()


function Area:new(room) 
    self.room = room 
    self.game_objects = {}
end 

function Area:update(dt) 
    for i = #self.game_objects, 1, -1 do 
        local game_object = self.game_objects[i]
        game_object:update(dt)
        if game_object.dead then table.remove(self.game_objects, i) end 
    end 
end 

function Area:draw() 
    for _, game_object in ipairs(self.game_objects) do game_object:draw() end 
end 

function Area:addGameObject(game_object_type, x, y, a, b, c, d, e)
    local opts = opts or {}
    local game_object = _G[game_object_type](self, x or 0, y or 0,  a, b, c, d, e)
    table.insert( self.game_objects, game_object)
    return game_object
end 

function Area:getGameObjects(callback)
    local match_objects = {}
    for i = #self.game_objects, 1, -1 do 
        local game_object = self.game_objects[i]
        if callback(game_object) == true then table.insert(match_objects, game_object) end 
    end
    return match_objects
end 