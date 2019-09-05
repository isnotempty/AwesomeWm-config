local wibox = require("wibox")

helper = {}

function helper.pad(size)
    local str = ""
    for i = 1, size do
        str = str .. " "
    end
    local pad = wibox.widget.textbox(str)
    return pad
end

return helper