--------        LIBRARY
------------------------------------------------------------------------------------
local awful       = require("awful")
local beautiful   = require("beautiful")
local gears       = require("gears")
local wibox       = require("wibox")
local util        = require("utilities")


exit_screen       = {}


-- Get screen geometry
local screen_geometry = awful.screen.focused().geometry
local alert_icon      = wibox.widget.imagebox(os.getenv("HOME") .. "/.config/awesome/resources/icons/others/yellow.png")


local warning_text    = util.text("WARNING SYSTEM","Industry-Bold  30")
local msg_widget      = util.text("DO YOU WANT EXIT FROM THE CURRENT SESSION  ?","Industry-Bold  22")


function custom_shape(cr, width, height)
  cr:move_to(0,0)
  cr:line_to(width,0)
  cr:line_to(width,height - height/4)
  cr:line_to(width - height/4,height)
  cr:line_to(0,height)
  cr:close_path()
end


-- Create the widget
exit_screen = wibox({
  x             = 400,
  y             = screen_geometry.height/4, 
  border_width  = 12, 
  border_color  = "#252e25", 
  ontop         = true, 
  visible       = false, 
  type          = "dock", 
  height        = 250  , 
  width         = screen_geometry.width/2.5 ,
  shape         = custom_shape,
  bg            = "#040404"
})


local exit_screen_grabber

function exit_screen_hide()
  exit_screen.visible = false
end

function exit_awesome()
  awesome.quit()
end

function exit_screen:show()
  exit_screen.visible = true
end

-- BTN 1
local btn_1 = util.btn("YES - EXIT","Industry-Bold 15",custom_shape)
btn_1:buttons(gears.table.join(
                 awful.button({ }, 1, function ()
                  exit_awesome()
                 end)
))

-- BTN 2
local btn_2 = util.btn("CANCEL","Industry-Bold 15",custom_shape)
btn_2:buttons(gears.table.join(
                 awful.button({ }, 1, function ()
                  exit_screen_hide()
                 end)
))

exit_screen:setup {
  {
    {
      {
        alert_icon,
        warning_text ,
        layout = wibox.layout.align.horizontal,
      },
      top = 0,
      right = 10,
      left = 10,
      bottom = 0,
      widget = wibox.container.margin
    },
    fg = "#C0B738",
    widget = wibox.container.background
  },
  {
    {
      nil,
      msg_widget,
      nil,
      layout = wibox.layout.align.horizontal
    },
    top = 10,
    right = 10,
    left = 10,
    bottom = 10,
    widget = wibox.container.margin
  },
  {
    nil,
    {
      btn_1,
      btn_2,
      expand = "none",
      layout = wibox.layout.align.horizontal
    },
    top = 20,
    right = 10,
    left = 10,
    bottom = 20,
    widget = wibox.container.margin
  },
  layout = wibox.layout.flex.vertical
}


return exit_screen