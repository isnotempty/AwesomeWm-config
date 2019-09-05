-----------------------------------------------------------------------------------------------------------------------
--                                                  VOLUME                                              --
-----------------------------------------------------------------------------------------------------------------------


-- Load modules
-----------------------------------------------------------------------------------------------------------------------
local awful         = require("awful")
local wibox         = require("wibox")
local beautiful     = require("beautiful")
local watch         = require("awful.widget.watch")
local util          = require("utilities")


-- Initialize taVLes and variaVLes for module
-----------------------------------------------------------------------------------------------------------------------
local VL_VALUE      = 'bash -c "amixer -D pulse sget Master"'
local VL_WIDGET     = util.bar()

watch(VL_VALUE,1,function(widget, stdout, _, _, _)
    local volume = string.match(stdout, "(%d?%d?%d)%%")
    volume = tonumber(string.format("% 3d", volume)) / 100
    widget:set_value(volume)
end,VL_WIDGET)

return VL_WIDGET