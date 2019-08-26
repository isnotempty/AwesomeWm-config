local cairo     = require("lgi").cairo
local wibox     = require('wibox')
local awful     = require('awful')
local gears     = require("gears")

local surface   = cairo.ImageSurface(cairo.Format.RGB24,20,20)
local cr = cairo.Context(surface)


local _M = {}