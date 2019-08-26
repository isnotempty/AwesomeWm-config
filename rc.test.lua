
-- Load modules
-----------------------------------------------------------------------------------------------------------------------
local awful         =   require("awful")
local beautiful     =   require("beautiful")
local gears         =   require("gears")
local naughty 		= 	require("naughty")
local xresources    =   require("beautiful.xresources")
local wibox         =   require("wibox")
                        require("awful.autofocus")
                        require("util.shape")



--------        ERROR HANLDING    
------------------------------------------------------------------------------------
                        require("checking_error")


--------        Environment       
------------------------------------------------------------------------------------
local env           =   require("environment")
env:init()

--------        Rules      
------------------------------------------------------------------------------------
require("core.rules")

--------        Layouts          
------------------------------------------------------------------------------------
local layout = require("core.layouts")
layout:init()

--------        keys          
------------------------------------------------------------------------------------
local keys   = require("core.keys")

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
local systray = require("core.systray")

-- Textclock
------------------------------------------------------------------------------------
local textclock = wibox.widget.textclock(" %d/%m/%Y - %H:%M GMT", 60)

-- Keyboard map indicator and switcher
------------------------------------------------------------------------------------
local keyboardlayout = awful.widget.keyboardlayout()


-- sysmon
------------------------------------------------------------------------------------
local sysmon = {}
sysmon.battery = require("widgets.battery")


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
            s.mylayoutbox
        },
        {
            layout = wibox.layout.flex.horizontal,
        },
        {
            layout = wibox.layout.flex.horizontal,
            env.widget_name("  BAT"),
            sysmon.battery,
            env.margin(systray.sys_widget)
        }
    }

    -- bottom wibar
    s.wibar_bottom = awful.wibar({ position = "bottom", screen = s, height =  40 })
    s.wibar_bottom:setup{
        layout = wibox.layout.align.horizontal,
        {
            layout = wibox.layout.align.horizontal,
            env.wrapper(taglist[s])
        },
        {
            layout = wibox.layout.align.horizontal,
            env.wrapper(s.mytasklist)
        },
        {
            layout = wibox.layout.align.horizontal,
            env.wrapper(keyboardlayout),
            env.wrapper(textclock)
        }
    }

end)


client.connect_signal("manage", function (c)
    if awesome.startup
      and not c.size_hints.user_position
      and not c.size_hints.program_position then
        awful.placement.no_offscreen(c)
    end
end)