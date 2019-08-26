--------        LIBRARY
------------------------------------------------------------------------------------
local awful       = require("awful")
local keygrabber  = require("awful.keygrabber")
local beautiful   = require("beautiful")
local helper      = require("util.helper")
local gears       = require("gears")
local wibox       = require("wibox")


-- Get screen geometry
local screen_geometry = awful.screen.focused().geometry


local alert_icon          = wibox.widget.imagebox(beautiful.alert_icon )

local warning_text= wibox.widget.textbox(" WARNING SYSTEM ")
warning_text.font   = "Industry-Bold  22"

local msg_widget  = wibox.widget.textbox("DO YOU WANT EXIT FROM THE CURRENT SESSION AWESOME ?")
msg_widget.font   = "Industry-Bold  18"


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
  x             = screen_geometry.width/4,
  y             = screen_geometry.height/4, 
  border_width  = 12, 
  border_color  = beautiful.exit_screen.border, 
  ontop         = true, 
  visible       = false, 
  type          = "dock", 
  height        = screen_geometry.height/3  , 
  width         = screen_geometry.width/2.5 ,
  shape         = custom_shape,
  bg            = beautiful.exit_screen.bg 
})


local exit_screen_grabber

function exit_screen_hide()
  exit_screen.visible = false
end

function exit_awesome()
  awesome.quit()
end

function exit_screen_show()
  exit_screen.visible = true
end

-- BTN 1
local text_1  = wibox.widget.textbox(" YES - EXIT ")
text_1.font   = "Industry-Bold 15"
local btn_1 = wibox.container.background(text_1,beautiful.exit_screen.button,custom_shape)
btn_1:buttons(gears.table.join(
                 awful.button({ }, 1, function ()
                  exit_awesome()
                 end)
))

-- generate button



-- BTN 2
local text_2  = wibox.widget.textbox(" CANCEL ")
text_2.font   = "Industry-Bold 15"
local btn_2 = wibox.container.background(text_2,beautiful.exit_screen.button,custom_shape)

-- change cursor 
btn_1:connect_signal("mouse::enter", function()
  btn_1.bg  = beautiful.exit_screen.pressed
  local w = mouse.current_wibox
  old_cursor, old_wibox = w.cursor, w
  w.cursor = "hand1"
end)

btn_1:connect_signal("mouse::leave", function()
  btn_1.bg  = beautiful.exit_screen.button
  if old_wibox then
      old_wibox.cursor = old_cursor
      old_wibox = nil
  end
end)

btn_2:connect_signal("mouse::enter", function()
  btn_2.bg  = beautiful.exit_screen.pressed
  local w = mouse.current_wibox
  old_cursor, old_wibox = w.cursor, w
  w.cursor = "hand1"
end)

btn_2:connect_signal("mouse::leave", function()
  btn_2.bg  = beautiful.exit_screen.button
  if old_wibox then
      old_wibox.cursor = old_cursor
      old_wibox = nil
  end
end)


btn_2:buttons(gears.table.join(
                 awful.button({ }, 1, function ()
                  exit_screen_hide()
                 end)
))

exit_screen:setup {
  nil,
  {
    {
      alert_icon,
      warning_text ,
      layout = wibox.layout.align.horizontal,
    },
    top = 10,
    right = 10,
    left = 10,
    bottom = 10,
    widget = wibox.container.margin
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
      forced_width  = 100,
      layout = wibox.layout.align.horizontal
    },
    top = 10,
    right = 10,
    left = 10,
    bottom = 10,
    widget = wibox.container.margin
  },
  layout = wibox.layout.flex.vertical
}


--keygrabber
awful.keygrabber.run(function(mod, key, event)
  if event == "release" then return end

  if  key == 'Escape'    then 
    exit_screen_hide()
  else   
    awful.keygrabber.stop(grabber)
  end
end)