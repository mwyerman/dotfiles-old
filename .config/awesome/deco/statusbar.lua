-- Standard awesome library
local gears = require("gears")
local awful = require("awful")

-- Wibox handling library
local wibox = require("wibox")

-- Custom Local Library: Common Functional Decoration
local deco = {
    wallpaper = require("deco.wallpaper"),
    taglist = require("deco.taglist"),
    tasklist = require("deco.tasklist"),
    cpu = require("deco.widgets.cpu-widget.cpu-widget"),
    fs = require("deco.widgets.fs-widget.fs-widget"),
}

local taglist_buttons = deco.taglist()
local tasklist_buttons = deco.tasklist()

local _M = {}

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

-- {{{ Wibar
-- Create a textclock widget
mytextclock = wibox.widget.textclock("%a %b %d, %l:%M%P")
emptywidget = wibox.widget.textbox("")

awful.screen.connect_for_each_screen(function(s)
    -- Wallpaper
    set_wallpaper(s)

    -- Create an imagebox widget which will contain an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    s.mylayoutbox = awful.widget.layoutbox(s)
    s.mylayoutbox:buttons(gears.table.join(
        awful.button({}, 1, function()
            awful.layout.inc(1)
        end),
        awful.button({}, 3, function()
            awful.layout.inc(-1)
        end),
        awful.button({}, 4, function()
            awful.layout.inc(1)
        end),
        awful.button({}, 5, function()
            awful.layout.inc(-1)
        end)
    ))

    -- Create a taglist widget
    s.mytaglist = awful.widget.taglist({
        screen = s,
        filter = awful.widget.taglist.filter.all,
        buttons = taglist_buttons,
    })

    -- Create a tasklist widget
    s.mytasklist = awful.widget.tasklist({
        screen = s,
        filter = awful.widget.tasklist.filter.currenttags,
        buttons = tasklist_buttons,
        layout = {
            spacing = 10,
            layout = wibox.layout.fixed.horizontal,
            valign = "center",
            halign = "center",
        },
    })

    -- Create the wibox
    s.mywibox = awful.wibar({ position = "top", screen = s })

    -- Add widgets to the wibox
    s.mywibox:setup({
        layout = wibox.layout.align.horizontal,
        expand = "none",
        { -- Left widgets
            layout = wibox.layout.fixed.horizontal,
            spacing = 10,
            emptywidget,
            RC.launcher,
            s.mytaglist,
        },
        s.mytasklist, -- Middle widget
        { -- Right widgets
            deco.fs(),
            deco.cpu(),
            layout = wibox.layout.fixed.horizontal,
            spacing = 10,
            wibox.widget.systray(),
            mytextclock,
            emptywidget,
        },
    })
end)
-- }}}
