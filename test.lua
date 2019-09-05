local cairo = require("lgi").cairo

local img = cairo.ImageSurface.create(cairo.Format.ARGB32, 50, 50)

-- Create a context
local cr  = cairo.Context(img)

-- Set a red source
cr:set_source(1, 0, 0)
-- Alternative:
cr:set_source(gears.color("#ff0000"))