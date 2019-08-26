local awful = require("awful")

local screen = {}

screen.screen_geometry = awful.screen.focused().geometry

return screen