local wibox       = require("wibox")

local module      = {}

local function new(textbox,font_name,shape_form)
    local button = wibox.widget {
        {
            {
                text = "   "..textbox.."   ",
                font = font_name,
                widget = wibox.widget.textbox
            },
            layout = wibox.layout.align.horizontal
        },
        bg = "#191F19",
        shape = shape_form,
        widget = wibox.container.background
    }

    -- change color
    button:connect_signal("mouse::enter", function()
        button.bg  = "#D60B17"
        local w = mouse.current_wibox
        old_cursor, old_wibox = w.cursor, w
        w.cursor = "hand1"
      end)
      
    button:connect_signal("mouse::leave", function()
        button.bg  = "#191F19"
        if old_wibox then
            old_wibox.cursor = old_cursor
            old_wibox = nil
        end
    end)
    
    return button
end


return setmetatable(module, { __call = function(_, ...) return new(...) end })