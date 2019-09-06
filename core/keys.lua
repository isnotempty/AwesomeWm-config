-----------------------------------------------------------------------------------------------------------------------
--                                                  keys                                              --
-----------------------------------------------------------------------------------------------------------------------

-- Load modules
--------------------------------------------------------------------------------------
local awful         = require("awful")
local gears         = require("gears")
local menubar       = require("menubar")
local hotkeys_popup = require("awful.hotkeys_popup")
local env           = require("environment")
local exit_screen   = require("widgets.exit_screen")
env:init()                                     

--variable
local keys = {}

-- global keys
--------------------------------------------------------------------------------------
keys.globalkeys = gears.table.join(
    -- change layout
    awful.key({ env.mod,           }, "space", function () awful.layout.inc( 1) end,
              {description = "select next", group = "layout"}),
    awful.key({ env.mod, "Shift"   }, "space", function () awful.layout.inc(-1) end,
              {description = "select previous", group = "layout"}),
    -- tag
    awful.key({ env.mod,           }, "F1",      hotkeys_popup.show_help,
              {description="show help", group="awesome"}),
    awful.key({ env.mod,           }, "Left",   awful.tag.viewprev,
              {description = "view previous", group = "tag"}),
    awful.key({ env.mod,           }, "Right",  awful.tag.viewnext,
              {description = "view next", group = "tag"}),
    awful.key({ env.mod,           }, "Tab", awful.tag.history.restore,
        {description = "go back", group = "tag"}),

    awful.key({ env.mod,           }, "u",
        function ()
            uc = awful.client.urgent.get()
            if uc ~= nil then
                awful.client.urgent.jumpto()
            end
        end,
        {description = "jump to urgent client", group = "client"}),

    -- Standard program
    awful.key({ env.mod,           }, "Return", function () awful.spawn(env.term) end,
              {description = "open a terminal", group = "launcher"}),
    awful.key({ env.mod, "Control" }, "r", awesome.restart,
              {description = "reload awesome", group = "awesome"}),
    awful.key({ env.mod, "Shift"   }, "q", function() exit_screen:show() end,
              {description = "quit awesome", group = "awesome"}),
    awful.key({ }, "XF86PowerOff", function() exit_screen:show() end,
              {description = "quit awesome", group = "awesome"}),
    
    -- change focus client
    awful.key({ env.mod,           }, "j",
              function () awful.client.focus.byidx( 1) end,
        {description = "focus next by index", group = "client"}),
    awful.key({ env.mod,           }, "k",
              function () awful.client.focus.byidx(-1) end,
        {description = "focus previous by index", group = "client"}),
        
    -- lock screen
    awful.key({ env.mod }, "l", function () awful.util.spawn("light-locker-command -l", false) end),

    -- Volume Keys
    awful.key({}, "XF86AudioLowerVolume", function ()
        awful.util.spawn("amixer -q -D pulse sset Master 5%-", false)
    end),
    awful.key({}, "XF86AudioRaiseVolume", function ()
        awful.util.spawn("amixer -q -D pulse sset Master 5%+", false)
    end),
    awful.key({}, "XF86AudioMute", function ()
        awful.util.spawn("amixer -D pulse set Master 1+ toggle", false)
    end),
    -- Media Keys
    awful.key({}, "XF86AudioPlay", function()
        awful.util.spawn("playerctl play-pause", false)
    end),
    awful.key({}, "XF86AudioNext", function()
        awful.util.spawn("playerctl next", false)
    end),
    awful.key({}, "XF86AudioPrev", function()
        awful.util.spawn("playerctl previous", false)
    end),
  

    -- Brightness
    awful.key({ env.mod }, "Up", function ()
        awful.util.spawn("xbacklight -inc 5") end),
    awful.key({ env.mod }, "Down", function ()
        awful.util.spawn("xbacklight -dec 5") end),
    awful.key({ }, "XF86MonBrightnessDown", function ()
        awful.util.spawn("xbacklight -dec 15") end),
    awful.key({ }, "XF86MonBrightnessUp", function ()
        awful.util.spawn("xbacklight -inc 15") end),

    -- restore minimized windows
    awful.key({ env.mod, "Control" }, "n",
        function ()
            local c = awful.client.restore()
            -- Focus restored client
            if c then
              c:emit_signal(
                  "request::activate", "key.unminimize", {raise = true}
              )
            end
        end,{description = "restore minimized", group = "client"}),

    -- screenshots
    awful.key({ }, "Print", function ()
        awful.util.spawn(env.themedir  .. "/scripts/screenshot.sh ") end),
    awful.key({ env.mod }, "Print", function ()
        awful.util.spawn(env.themedir  .. "/scripts/screenshot.sh -s") end),
        
    -- Menubar
    awful.key({ env.mod }, "p", function() menubar.show() end,
              {description = "show the menubar", group = "launcher"})
)

keys.clientkeys = gears.table.join(
    -- sticky client
    awful.key({ env.mod,           }, "s",      function (c) c.sticky = not c.sticky  end,
            {description = "sticky client " , group = "client"}),

    -- toggle fullscreen
    awful.key({ env.mod,           }, "f",
        function (c)
            c.fullscreen = not c.fullscreen
            c:raise()
        end,{description = "toggle fullscreen", group = "client"}),

    -- minimize
    awful.key({ env.mod,           }, "n",
        function (c)
            c.minimized = true
        end ,{description = "minimize", group = "client"}),
    
    -- (un)maximize vertically
    awful.key({ env.mod , "Control"}, "m",
        function (c)
            c.maximized_vertical = not c.maximized_vertical
            c:raise()
        end ,{description = "(un)maximize vertically", group = "client"}),
    
    -- (un)maximize vertically
    awful.key({ env.mod }, "m",
        function (c)
            c.maximized = not c.maximized
            c:raise()
        end , {description = "(un)maximize horizontally", group = "client"}),

    -- toggle keep on top
    awful.key({ env.mod,           }, "t",      function (c) c.ontop = not c.ontop  end,
        {description = "toggle keep on top", group = "client"}),
    
    -- kill client    
    awful.key({ env.mod  }, "c", 
        function (c) 
            c:kill() 
        end,{description = "close", group = "client"})
)

-- Bind all key numbers to tags.
---------------------------------------------------------------------
for i = 1, 9 do
    keys.globalkeys = gears.table.join(keys.globalkeys,
        -- View tag only.
        -------------------------------------------------------------
        awful.key({ env.mod }, "#" .. i + 9,
                  function ()
                        local screen = awful.screen.focused()
                        local tag = screen.tags[i]
                        if tag then
                           tag:view_only()
                        end
            end,{description = "view tag #"..i, group = "tag"}),


        -- Move client to tag.
        -------------------------------------------------------------
        awful.key({ env.mod, "Shift" }, "#" .. i + 9,
            function ()
                if client.focus then
                    local tag = client.focus.screen.tags[i]
                    if tag then
                        client.focus:move_to_tag(tag)
                    end
                end
            end,{description = "move focused client to tag #"..i, group = "tag"})

    )
end

keys.clientbuttons = gears.table.join(
    awful.button({ }, 1, function (c) client.focus = c; c:raise() end),
    awful.button({ env.mod }, 1, awful.mouse.client.move),
    awful.button({ env.mod }, 3, awful.mouse.client.resize))

root.keys(keys.globalkeys)

return keys