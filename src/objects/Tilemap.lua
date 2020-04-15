--Base class for tilemap 

Tilemap = Entity:extend()

function Tilemap:new(area, x, y, map_path) 
    
    --get the path to the mapdata exported from tiled (with tileset embeded mode) 
    self.map_path = map_path

    self.area = area

    self.x = x 
    self.y = y

    self.map = require(self.map_path) 
    self.map_width = self.map.width 
    self.map_height = self.map.height 
    self.tile_width = self.map.tilewidth 
    self.tile_height = self.map.tileheight

    --get the tileset for the map
    self.tileset = self.map.tilesets[1]
    local tileset = self.tileset
    self.image = love.graphics.newImage("res/maps/" .. tileset.image)

    --set quads for the tileset image 
    self.quads = {}
    for y = 0, (self.tileset.imageheight / self.tileset.tileheight) - 1 do
        for x = 0, (self.tileset.imagewidth / self.tileset.tilewidth) - 1 do 
            local quad = love.graphics.newQuad(
                x * self.tileset.tilewidth,
                y * self.tileset.tileheight,
                self.tileset.tilewidth,
                self.tileset.tileheight,
                self.tileset.imagewidth, 
                self.tileset.imageheight
            )
            table.insert(self.quads, quad)
        end
    end 

    --parse the tiled map data and create a single SpriteBatch drawable
    self.mapBatch = love.graphics.newSpriteBatch(self.image, 128, "static")
    for i, layer in ipairs(self.map.layers) do 
        if layer.type == "tilelayer" then 
            for y = 0, layer.height - 1 do 
                for x = 0, layer.width - 1 do 
                    local index = (x + y * layer.width) + 1
                    local tid = layer.data[index] 

                    if tid ~= 0 then 
                        local quad = self.quads[tid]
                        local xx = x * self.tileset.tilewidth 
                        local yy = y * self.tileset.tileheight

                        self.mapBatch:add(
                            quad,
                            xx, 
                            yy
                        )

                    end 
                end 
            end 
    
            --add objectgroup layer's object to the room
        elseif layer.type == "objectgroup" then 
            for i, object in ipairs(layer.objects) do 
                local game_object = object.type 
                local image_path = object.properties["image_path"]
                local initial_tag = object.properties["initial_tag"]
                print(game_object)
                area:addGameObject(game_object, object.x, object.y, image_path, initial_tag)
            end 
        end
    end

end 

function Tilemap:update(dt)

end 

function Tilemap:draw()
    love.graphics.draw(self.mapBatch)
end 

function Tilemap:getAtPixel(x, y)
    local tx = math.floor(x / GRID)
    local ty = math.floor(y / GRID)
    local base_layer = self.map.layers[1]
    local index = (tx + ty * base_layer.width) + 1
    return base_layer.data[index]
end 

function Tilemap:getBounds() 
    return self.x, self.y, self.map.width * self.map.tilewidth, self.map.height * self.map.tileheight
end 