local gears         = require("gears")
local wibox         = require("wibox")
local beautiful     = require("beautiful")
local watch         = require("awful.widget.watch")

local BAT_CAP       = 'bash -c "cat /sys/class/power_supply/BAT0/capacity"'

-- Set colors
local active_color      = beautiful.color.blue
local background_color  = beautiful.color.gray

--shape
function custom_shape(cr, width, height)
  cr:move_to(0,0)
  cr:line_to(width,0)
  cr:line_to(width,height - height/4)
  cr:line_to(width - height/4,height)
  cr:line_to(0,height)
  cr:close_path()
end

local BAT_WIDGET = wibox.widget{
  max_value         = 100,
  value             = 0,
  paddings          = 1,
  forced_height     = 10,
  margins           = {
      top           = 8,
      bottom        = 8,
      right         = 8 
    },
  forced_width      = 150,
  color             = active_color,
  background_color  = background_color,
  border_width      = 0,
  border_color      = active_color,
  widget            = wibox.widget.progressbar,
}



watch(BAT_CAP,20,function(widget, stdout, _, _, _)
    local level = tonumber(stdout)
    if level > 20 then
      widget.background_color = beautiful.color.green
    else
      widget.background_color = beautiful.color.red
    end
    widget.value = tonumber(stdout)
end,BAT_WIDGET)

return BAT_WIDGET