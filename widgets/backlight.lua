local gears         = require("gears")
local wibox         = require("wibox")
local beautiful     = require("beautiful")
local watch         = require("awful.widget.watch")

local BL_VALUE      = 'bash -c "xbacklight -get"'

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

local BL_WIDGET = wibox.widget{
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



watch(BL_VALUE,1,function(widget, stdout, _, _, _)
    local brightness = string.match(stdout, '(%d+)')
    local level = tonumber(brightness)
    widget.value = tonumber(level)
end,BL_WIDGET)

return BL_WIDGET