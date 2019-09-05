-----------------------------------------------------------------------------------------------------------------------
--                                                Layouts config                                                     --
-----------------------------------------------------------------------------------------------------------------------
local awful         =   require("awful")


local layouts       =   {}

-- Build  table
-----------------------------------------------------------------------------------------------------------------------
local function new()
    local layset = {
        awful.layout.suit.tile,
        awful.layout.suit.floating,
    --    awful.layout.suit.tile.left,
    --    awful.layout.suit.tile.bottom,
    --    awful.layout.suit.tile.top,
        awful.layout.suit.fair,
    --    awful.layout.suit.fair.horizontal,
    --    awful.layout.suit.spiral,
    --    awful.layout.suit.spiral.dwindle,
    --    awful.layout.suit.max,
    --    awful.layout.suit.max.fullscreen,
    --    awful.layout.suit.magnifier,
    --    awful.layout.suit.corner.nw
    }
    awful.layout.layouts = layset
end


return setmetatable(layouts, { __call = function(_, ...) return new(...) end })