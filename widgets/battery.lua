local wibox         = require("wibox")
local beautiful     = require("beautiful")
local util          = require("utilities")
local watch         = require("awful.widget.watch")

local BAT_CAP       = 'bash -c "cat /sys/class/power_supply/BAT0/capacity"'

local BAT_WIDGET    = util.bar()


watch(BAT_CAP,20,function(widget, stdout, _, _, _)
    
    local level = tonumber(stdout) / 100
    widget:set_value(level)

end,BAT_WIDGET)

return BAT_WIDGET