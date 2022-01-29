-- Standard awesome library
local gears = require("gears")
local beautiful = require("beautiful")
local awful = require("awful")

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

function set_wallpaper(s)
    -- Wallpaper
    if beautiful.wallpaper == "nitrogen" then
        awful.spawn.with_shell("nitrogen --restore")
    elseif beautiful.wallpaper then
        local wallpaper = beautiful.wallpaper
        -- If wallpaper is a function, call it with the screen
        if type(wallpaper) == "function" then
            wallpaper = wallpaper(s)
        end
        gears.wallpaper.maximized(wallpaper, s, true)
    end

    -- Enable gaps
    -- beautiful.useless_gap = 20
    -- beautiful.gap_single_client = true
end

-- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
screen.connect_signal("property::geometry", set_wallpaper)
