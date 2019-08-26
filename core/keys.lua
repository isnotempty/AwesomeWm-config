-----------------------------------------------------------------------------------------------------------------------
--                                                  Error handling                                               --
-----------------------------------------------------------------------------------------------------------------------

local awful         = require("awful")
local gears         = require("gears")
local menubar       = require("menubar")
local hotkeys_popup = require("awful.hotkeys_popup")
local env           = require("environment")
                      require("widgets.logout")
                  

                    
env:init()




--variable
local keys = {}

-- global keys
keys.globalkeys = gears.table.join(
    awful.key({ env.mod,           }, "s",      hotkeys_popup.show_help,
              {description="show help", group="awesome"}),
    awful.key({ env.mod,           }, "Left",   awful.tag.viewprev,
              {description = "view previous", group = "tag"}),
    awful.key({ env.mod,           }, "Right",  awful.tag.viewnext,
              {description = "view next", group = "tag"}),
    awful.key({ env.mod,           }, "Tab", awful.tag.history.restore,
        {description = "go back", group = "tag"}),

    -- Standard program
    awful.key({ env.mod,           }, "Return", function () awful.spawn(env.term) end,
              {description = "open a terminal", group = "launcher"}),
    awful.key({ env.mod, "Control" }, "r", awesome.restart,
              {description = "reload awesome", group = "awesome"}),
    awful.key({ env.mod, "Shift"   }, "q", function() exit_screen_show() end,
              {description = "quit awesome", group = "awesome"}),
    awful.key({ }, "XF86PowerOff", function() exit_screen_show() end,
              {description = "quit awesome", group = "awesome"}),


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

    -- screenshots
    awful.key({ }, "Print", function ()
        awful.util.spawn(env.home .. "/bin/screenshot.sh ") end),
    awful.key({ env.mod }, "Print", function ()
        awful.util.spawn(env.home .. "/bin/screenshot.sh -s") end),
        
    -- Menubar
    awful.key({ env.mod }, "p", function() menubar.show() end,
              {description = "show the menubar", group = "launcher"})
)

keys.clientkeys = gears.table.join(
    -- Move floating client (relative)
    awful.key({ env.alt , "Shift" }, "Down", function (c) c:relative_move( 0, 40, 0, 0 ) end,
    {description = "move client to Down", group = "client"}),
    awful.key({ env.alt , "Shift" }, "Up", function (c) c:relative_move( 0, -40, 0, 0 ) end,
    {description = "move client to top", group = "client"}),
    awful.key({ env.alt , "Shift" }, "Left", function (c) c:relative_move( -40, 0, 0, 0 ) end,
    {description = "move client to left", group = "client"}),
    awful.key({ env.alt , "Shift" }, "Right", function (c) c:relative_move( 40, 0, 0, 0 ) end,
    {description = "move client to Right", group = "client"}),

    -- toggle floating mode
    awful.key({ env.mod, "Control" }, "space",  awful.client.floating.toggle                     ,
              {description = "toggle floating", group = "client"}),

    awful.key({ env.mod,           }, "f",
    function (c)
        c.fullscreen = not c.fullscreen
        c:raise()
    end,
    {description = "toggle fullscreen", group = "client"}),

  awful.key({ env.mod, "Control" }, "m",
        function (c)
            c.maximized_vertical = not c.maximized_vertical
            c:raise()
        end ,
        {description = "(un)maximize vertically", group = "client"}),

  awful.key({ env.mod  }, "c",      function (c) c:kill() end,
              {description = "close", group = "client"})
)

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it work on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 9 do
    keys.globalkeys = gears.table.join(keys.globalkeys,
        -- View tag only.
        awful.key({ env.mod }, "#" .. i + 9,
                  function ()
                        local screen = awful.screen.focused()
                        local tag = screen.tags[i]
                        if tag then
                           tag:view_only()
                        end
                  end,
                  {description = "view tag #"..i, group = "tag"}),
        -- Toggle tag display.
        awful.key({ env.mod, "Control" }, "#" .. i + 9,
                  function ()
                      local screen = awful.screen.focused()
                      local tag = screen.tags[i]
                      if tag then
                         awful.tag.viewtoggle(tag)
                      end
                  end,
                  {description = "toggle tag #" .. i, group = "tag"}),
        -- Move client to tag.
        awful.key({ env.mod, "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus then
                          local tag = client.focus.screen.tags[i]
                          if tag then
                              client.focus:move_to_tag(tag)
                          end
                     end
                  end,
                  {description = "move focused client to tag #"..i, group = "tag"}),
        -- Toggle tag on focused client.
        awful.key({ env.mod, "Control", "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus then
                          local tag = client.focus.screen.tags[i]
                          if tag then
                              client.focus:toggle_tag(tag)
                          end
                      end
                  end,
                  {description = "toggle focused client on tag #" .. i, group = "tag"})
    )
end

keys.clientbuttons = gears.table.join(
    awful.button({ }, 1, function (c) client.focus = c; c:raise() end),
    awful.button({ env.mod }, 1, awful.mouse.client.move),
    awful.button({ env.mod }, 3, awful.mouse.client.resize))

root.keys(keys.globalkeys)

return keys