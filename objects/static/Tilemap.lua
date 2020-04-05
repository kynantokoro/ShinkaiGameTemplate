--Base class for tilemap 

Tilemap = Entity:extend()

function Tilemap:new(area, x, y, map_path) --{image_path, map_path}
    
    self.map_path = map_path

    self.area = area

    self.map = require(self.map_path) 

    self.quads = {}

    self.tileset = self.map.tilesets[1]
    local tileset = self.tileset
    self.image = love.graphics.newImage("res/maps/" .. tileset.image)

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
        elseif layer.type == "objectgroup" then 
            for i, object in ipairs(layer.objects) do 
                local game_object = object.type 
                print(game_object)
                area:addGameObject(game_object, object.x, object.y, {image_path = "res/PH.png"})
            end 
        end
    end

    --self.tileset = self.map.tilesets[1]

end 

function Tilemap:update(dt)

end 

function Tilemap:draw()
    love.graphics.draw(self.mapBatch)
end 

function Tilemap:getAtPixel(x, y)
    local tx = math.floor(x / GRID) + 1
    local ty = math.floor(y / GRID) + 1
    return self.map[ty][tx] 
end 

function Tilemap:loadTiledMap(map_path) 

    local map = require(map_path) 

    map.quads = {}

    local tileset = map.tilesets[1]
    print(tileset.imagewidth)

    return map 
end 