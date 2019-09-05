-----------------------------------------------------------------------------------------------------------------------
--                                                  Environment config                                               --
-----------------------------------------------------------------------------------------------------------------------

local awful         = require("awful")
local beautiful     = require("beautiful")
local gears         = require("gears")
local wibox         = require("wibox")
local util          = require("utilities")

-- Initialize tables and variables for module
-----------------------------------------------------------------------------------------------------------------------
local env = {}


function env:init(args)
    --init vars
    args = args or {}

    -- env vars
    self.term       = "urxvt"
    self.mod        = args.mod or "Mod4"
    self.alt        = "Mod1"
    self.home       = os.getenv("HOME")
    self.editor_cmd = os.getenv("EDITOR") or "vim"
    self.editor_gui = "code"
    self.themedir   = self.home .. "/.config/awesome/"
    self.taglist    = {" TERM ", " WEB ", " CODE ", " FILES ", " OTHERS "}
    -- theme setup
	beautiful.init(env.themedir .. "theme.lua")
end



-- Wallpaper setup
--------------------------------------------------------------------------------
env.set_wallpaper = function(s)
	if beautiful.wallpaper then
		gears.wallpaper.maximized(beautiful.wallpaper, s, true)
	end
end


env.wrapper = function (s)
  local widget_bg = wibox.container.background(s,beautiful.color.green, custom_shape)
  return wibox.container.margin(widget_bg, 8, 5, 8, 8)
end

env.wrapper_tag = function (s)
  local widget_bg = wibox.container.background(s,beautiful.color.bg)
  return wibox.container.margin(widget_bg, 8, 5, 8, 8)
end

env.margin = function (widget)
  return wibox.container.margin(widget, 8, 10, 8, 8)
end

env.widget_name = function (name)
  local txt       = util.text(name)
  return wibox.container.margin(txt, 1, 2, 8, 8)
end

-- End
-----------------------------------------------------------------------------------------------------------------------
return env