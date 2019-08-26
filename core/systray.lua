--------        LIBRARY
------------------------------------------------------------------------------------
local awful       = require("awful")
local beautiful   = require("beautiful")
local gears       = require("gears")
local wibox       = require("wibox")


local systray = {}

systray.sys_widget   = wibox.widget{
    image = beautiful.show_apps,
    resize = true,
    width = 50,
    widget = wibox.widget.imagebox
}


local p = awful.popup {
    widget = awful.widget.tasklist {
        screen   = screen[1],
        filter   = awful.widget.tasklist.filter.allscreen,
        buttons  = tasklist_buttons,
        style    = {
            bg = beautiful.color.black
        },
        layout   = {
            spacing = 5,
            forced_num_rows = 2,
            layout = wibox.layout.grid.horizontal
        },
        widget_template = {
            {
                {
                    id     = 'clienticon',
                    widget = awful.widget.clienticon,
                },
                margins = 10,
                widget  = wibox.container.margin,
            },
            id              = 'background_role',
            forced_width    = 48,
            forced_height   = 48,
            widget          = wibox.container.background,
            create_callback = function(self, c, index, objects) --luacheck: no unused
                self:get_children_by_id('clienticon')[1].client = c
            end,
        },
    },
    ontop         = true, 
    visible = false,
    preferred_anchors   = {'front', 'back'},
}


p:bind_to_widget(systray.sys_widget)

return systray

