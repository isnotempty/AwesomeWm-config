local awful         =   require("awful")
local beautiful     =   require("beautiful")
local keys          =   require("core.keys")
local env           =   require("environment")
env:init()


awful.rules.rules = {
    -- all clients
    {
      rule = { },
      properties = {
        border_width = beautiful.border_width,
        border_color = beautiful.border_normal,
        focus = awful.client.focus.filter,
        maximized_horizontal = false,
        maximized_vertical = false,
        maximized = false,
        raise = true,
        keys = keys.clientkeys,
        buttons = keys.clientbuttons,
        screen = awful.screen.preferred,
        placement = awful.placement.no_overlap+awful.placement.no_offscreen,
        size_hints_honor = false,
      }
    },
    -- titlebars
    {
      rule_any = {
        type = { "dialog", "normal" }
      },
      properties = { titlebars_enabled = true }
    },
    { 
      rule = { name = "MPlayer" },
      properties = { floating = true } 
    },
    -- feh
    {
      rule_any = { class = {"feh","Lxappearance","Blueman-manager"} },
      properties = {
        floating = true,
        placement = awful.placement.centered,
        buttons = nil,
        keys = nil,
        sticky = true,
        titlebars_enabled = false,
      },
    },
    --firefox
    { 
      rule_any = { class = {"firefox","Google-chrome"} },
      properties = { tag = env.taglist[2] } 
    },
    --URxvt
    { 
      rule = { class = "URxvt" },
      properties = { tag = env.taglist[1] } 
    },
    --visual studio code
    { 
      rule = { class = "Code" },
      properties = { tag = env.taglist[3] } 
    },
    --thunar
    { 
      rule = { class = "Thunar" },
      properties = { tag = env.taglist[4] } 
    },
    --qBittorrent
    { 
      rule_any = { class = {"qBittorrent","hakuneko-desktop","YACReaderLibrary","Inkscape","Gimp"} },
      properties = { tag = env.taglist[5] } 
    },
    {
      rule_any = { type = { 'dialog' }, role = { 'pop-up' } },
      properties = {
        callback = function (c)
          local wa = screen[c.screen].workarea
          -- If a popup or dialog has the exact same size then the workarea its in
          -- don't make it floating, otherwise make it floating
          if c.width == wa.width and c.height == wa.height and c.x == wa.x and c.y == wa.y then
            c.floating = false
          else
            c.floating = true
            awful.placement.centered(c)
          end
        end
      }
    }

}
  