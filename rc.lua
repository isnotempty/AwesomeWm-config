
-- Load modules
-----------------------------------------------------------------------------------------------------------------------
local awful         =   require("awful")
local beautiful     =   require("beautiful")
local gears         =   require("gears")
local wibox         =   require("wibox")
local core          =   require("core")
local util          =   require("utilities")
                        require("awful.autofocus")
                        

--------        Environment       
------------------------------------------------------------------------------------
local env           =   require("environment")
env:init()
--------        Layouts          
------------------------------------------------------------------------------------
local layout = core.layouts

--------        keys          
------------------------------------------------------------------------------------
local keys   = core.keys

-- Taglist widget
--------------------------------------------------------------------------------
local taglist = {}

taglist.buttons = awful.util.table.join(
	awful.button({         }, 1, function(t) t:view_only() end),
	awful.button({         }, 2, awful.tag.viewtoggle),
	awful.button({         }, 4, function(t) awful.tag.viewnext(t.screen) end),
	awful.button({         }, 5, function(t) awful.tag.viewprev(t.screen) end)
)

--------        Tasklist      
------------------------------------------------------------------------------------
local tasklist_buttons = gears.table.join(
                     awful.button({ }, 1, function (c)
                                              if c == client.focus then
                                                  c.minimized = true
                                              else
                                                  c:emit_signal(
                                                      "request::activate",
                                                      "tasklist",
                                                      {raise = true}
                                                  )
                                              end
                                          end),
                     awful.button({ }, 3, function()
                                              awful.menu.client_list({ theme = { width = 250 } })
                                          end),
                     awful.button({ }, 4, function ()
                                              awful.client.focus.byidx(1)
                                          end),
                     awful.button({ }, 5, function ()
                                              awful.client.focus.byidx(-1)
                                          end))

-- Systray
------------------------------------------------------------------------------------

-- Textclock
------------------------------------------------------------------------------------
local textclock = wibox.widget.textclock(" %d/%m/%Y - %H:%M GMT", 60)


-- sysmon
------------------------------------------------------------------------------------
local sysmon = {}
sysmon.battery      = require("widgets.battery")
sysmon.backlight    = require("widgets.backlight")
sysmon.volume       = require("widgets.volume")

-- Screen setup
-----------------------------------------------------------------------------------------------------------------------
awful.screen.connect_for_each_screen(function(s)
    -- wallpaper
    env.set_wallpaper(s)

    s.mylayoutbox = awful.widget.layoutbox(s)
    s.mylayoutbox:buttons(gears.table.join(
                           awful.button({ }, 1, function () awful.layout.inc( 1) end),
                           awful.button({ }, 3, function () awful.layout.inc(-1) end),
                           awful.button({ }, 4, function () awful.layout.inc( 1) end),
                           awful.button({ }, 5, function () awful.layout.inc(-1) end)))
    
    -- Each screen has its own tag table.
    awful.tag(env.taglist, s, awful.layout.layouts[1])
    
    --taglist 
    taglist[s] = awful.widget.taglist{
        screen  = s,
        filter  = awful.widget.taglist.filter.all,
        style   = {
            shape = custom_shape
        }
    }
    
    -- tasklist
    s.mytasklist = awful.widget.tasklist {
        screen  = s,
        filter  = awful.widget.tasklist.filter.currenttags,
        buttons = tasklist_buttons,
        style    = {
            shape  = custom_shape,
        },
        layout   = {
            spacing = 10,
            layout  = wibox.layout.flex.horizontal
        },
    }

    -- bottom wibar
    s.wibar_top    = awful.wibar({ position = "top", screen = s, height =  35 })
    s.wibar_top:setup
    {
        layout = wibox.layout.align.horizontal,
        {
            layout = wibox.layout.flex.horizontal,
            env.wrapper_tag(taglist[s])
        },
        {
            layout = wibox.layout.flex.horizontal,
        },
        {
            layout = wibox.layout.flex.horizontal,
            wibox.widget.systray(),
            env.widget_name("VOLUME"),
            env.margin(sysmon.volume),
            env.widget_name("BACKLIGHT"),
            env.margin(sysmon.backlight),
            env.widget_name("BATTERY"),
            env.margin(sysmon.battery),
            
        }
    }

    -- bottom wibar
    s.wibar_bottom = awful.wibar({ position = "bottom", screen = s, height =  40 })
    s.wibar_bottom:setup{
        layout = wibox.layout.align.horizontal,
        {
            layout = wibox.layout.align.horizontal,
            
        },
        {
            layout = wibox.layout.align.horizontal,
            env.margin(s.mytasklist)
        },
        {
            layout = wibox.layout.align.horizontal,
            textclock,
            
        }
    }

end)
