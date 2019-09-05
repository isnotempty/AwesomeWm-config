--------        LIBRARY
------------------------------------------------------------------------------------
local setmetatable  = setmetatable
local gears         = require("gears")
local wibox         = require("wibox")

local module        = {}

local function new(text,font_name)
    return wibox.widget{
        markup = text,
        font   = font_name or "Time Won 9",
        align  = 'center',
        valign = 'center',
        widget = wibox.widget.textbox
    }
end

return setmetatable(module, { __call = function(_, ...) return new(...) end })