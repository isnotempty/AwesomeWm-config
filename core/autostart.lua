
-- Load modules
-----------------------------------------------------------------------------------------------------------------------
local awful         =   require("awful")

local function runOnce(cmd)
    findme = cmd
    firstspace = cmd:find(" ")
    if firstspace then
      findme = cmd:sub(0, firstspace-1)
    end
    awful.spawn.with_shell(string.format("pgrep -u $USER -x %s > /dev/null || (%s)", findme, cmd))
end


runOnce("nm-applet ")
--runOnce("compton -CGb")
runOnce("light-locker")