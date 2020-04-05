return {
  version = "1.2",
  luaversion = "5.1",
  tiledversion = "1.3.3",
  orientation = "orthogonal",
  renderorder = "right-down",
  width = 16,
  height = 16,
  tilewidth = 8,
  tileheight = 8,
  nextlayerid = 4,
  nextobjectid = 6,
  properties = {},
  tilesets = {
    {
      name = "Tileset_4/5",
      firstgid = 1,
      tilewidth = 8,
      tileheight = 8,
      spacing = 0,
      margin = 0,
      columns = 17,
      image = "greentile.png",
      imagewidth = 136,
      imageheight = 16,
      tileoffset = {
        x = 0,
        y = 0
      },
      grid = {
        orientation = "orthogonal",
        width = 8,
        height = 8
      },
      properties = {},
      terrains = {},
      tilecount = 34,
      tiles = {}
    }
  },
  layers = {
    {
      type = "tilelayer",
      id = 1,
      name = "Tile Layer 1",
      x = 0,
      y = 0,
      width = 16,
      height = 16,
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      properties = {},
      encoding = "lua",
      data = {
        14, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 12,
        11, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 11,
        11, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 11,
        11, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 11,
        11, 0, 0, 0, 0, 0, 0, 6, 4, 0, 0, 0, 0, 0, 0, 11,
        11, 0, 6, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 11,
        11, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 6, 4, 0, 0, 11,
        11, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 11,
        11, 0, 0, 0, 6, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 11,
        11, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 11,
        11, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 6, 4, 0, 0, 11,
        11, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 11,
        11, 0, 0, 0, 0, 6, 4, 0, 0, 0, 0, 0, 0, 0, 0, 11,
        11, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 11,
        11, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 11,
        7, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 5
      }
    },
    {
      type = "objectgroup",
      id = 3,
      name = "Object Layer 1",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      draworder = "topdown",
      properties = {},
      objects = {
        {
          id = 1,
          name = "",
          type = "Test",
          shape = "rectangle",
          x = 40,
          y = 16,
          width = 8,
          height = 8,
          rotation = 0,
          visible = true,
          properties = {
            ["image_path"] = "PH.png"
          }
        },
        {
          id = 2,
          name = "",
          type = "Test2",
          shape = "rectangle",
          x = 72,
          y = 24,
          width = 8,
          height = 8,
          rotation = 0,
          visible = true,
          properties = {
            ["image_path"] = "PH.png"
          }
        },
        {
          id = 5,
          name = "",
          type = "Test",
          shape = "rectangle",
          x = 24,
          y = 88,
          width = 8,
          height = 8,
          rotation = 0,
          visible = true,
          properties = {
            ["image_path"] = "PH.png"
          }
        }
      }
    },
    {
      type = "tilelayer",
      id = 2,
      name = "Tile Layer 2",
      x = 0,
      y = 0,
      width = 16,
      height = 16,
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      properties = {},
      encoding = "lua",
      data = {
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 22, 0, 23, 23, 23, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 22, 22, 22, 23, 23, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 23, 23, 22, 0, 0, 19, 0, 0, 22, 0, 0, 0, 0, 0,
        0, 0, 22, 22, 23, 23, 0, 19, 22, 22, 22, 0, 0, 0, 0, 0,
        0, 0, 0, 22, 22, 22, 22, 22, 22, 22, 22, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 19, 19, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
      }
    }
  }
}
