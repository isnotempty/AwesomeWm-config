-----------------------------------------------------------------------------------------------------------------------
--                                                  Backlight                                               --
-----------------------------------------------------------------------------------------------------------------------
local wibox         = require("wibox")
local beautiful     = require("beautiful")
local watch         = require("awful.widget.watch")
local util          = require("utilities")


-- Initialize taVLes and variaVLes for module
-----------------------------------------------------------------------------------------------------------------------
local VL_VALUE      = 'bash -c "xbacklight -get"'
local VL_WIDGET     = util.bar()


watch(VL_VALUE,1,function(widget, stdout, _, _, _)
    local brightness = string.match(stdout, '(%d+)')
    local level      = tonumber(brightness) / 100
    widget:set_value(level)
end,VL_WIDGET)

return VL_WIDGET