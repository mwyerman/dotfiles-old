-- Standard awesome library
local gears = require("gears")
local awful = require("awful")
-- local hotkeys_popup = require("awful.hotkeys_popup").widget
local hotkeys_popup = require("awful.hotkeys_popup")
-- Menubar library
local menubar = require("menubar")

-- Resource Configuration
local modkey = RC.vars.modkey
local terminal = RC.vars.terminal
local browser = RC.vars.browser
local filemanager = RC.vars.filemanager

local _M = {}

-- reading
-- https://awesomewm.org/wiki/Global_Keybindings

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
-- custom programs at bottom of config
-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

function _M.get()
    local globalkeys = gears.table.join(
        awful.key({ modkey }, "s", hotkeys_popup.show_help, { description = "show help", group = "awesome" }),

        --   -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
        -- Custom program

        -- steam
        awful.key({ modkey }, "g", function()
            awful.spawn("steam")
        end, {
            description = "steam",
            group = "applications",
        }),

        -- spotify
        awful.key({ modkey, "Shift" }, "g", function()
            awful.spawn("lutris")
        end, {
            description = "lutris",
            group = "applications",
        }),

        -- spotify
        awful.key({ modkey, "Shift" }, "s", function()
            awful.spawn("spotify")
        end, {
            description = "music",
            group = "applications",
        }),

        --   -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
        -- Tag browsing
        awful.key({ modkey }, "Left", awful.tag.viewprev, { description = "view previous", group = "tag" }),
        awful.key({ modkey }, "Right", awful.tag.viewnext, { description = "view next", group = "tag" }),
        awful.key({ modkey }, "Escape", awful.tag.history.restore, { description = "go back", group = "tag" }),

        awful.key({ modkey }, "j", function()
            awful.client.focus.byidx(1)
        end, {
            description = "focus next by index",
            group = "client",
        }),
        awful.key({ modkey }, "k", function()
            awful.client.focus.byidx(-1)
        end, {
            description = "focus previous by index",
            group = "client",
        }),

        --   -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
        -- Layout manipulation
        awful.key({ modkey, "Shift" }, "j", function()
            awful.client.swap.byidx(1)
        end, {
            description = "swap with next client by index",
            group = "client",
        }),
        awful.key({ modkey, "Shift" }, "k", function()
            awful.client.swap.byidx(-1)
        end, {
            description = "swap with previous client by index",
            group = "client",
        }),
        awful.key({ modkey, "Control" }, "j", function()
            awful.screen.focus_relative(1)
        end, {
            description = "focus the next screen",
            group = "screen",
        }),
        awful.key({ modkey, "Control" }, "k", function()
            awful.screen.focus_relative(-1)
        end, {
            description = "focus the previous screen",
            group = "screen",
        }),
        awful.key({ "Mod1" }, "Tab", function()
            awful.client.focus.history.previous()
            if client.focus then
                client.focus:raise()
            end
        end, {
            description = "go back",
            group = "client",
        }),

        --   -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
        -- Standard program

        -- terminal
        awful.key({ modkey }, "Return", function()
            awful.spawn(terminal)
        end, {
            description = "terminal",
            group = "applications",
        }),

        -- file manager
        awful.key({ modkey }, "e", function()
            awful.spawn(filemanager)
        end, {
            description = "file manager",
            group = "applications",
        }),

        -- browser
        awful.key({ modkey }, "b", function()
            awful.spawn(browser)
        end, {
            description = "browser",
            group = "applications",
        }),

        -- launcher
        awful.key({ modkey }, "space", function()
            awful.spawn("/home/mwyerman/.config/rofi/launchers/text/launcher.sh")
        end, {
            description = "launcher",
            group = "applications",
        }),

        -- reload/quit awesome
        awful.key({ modkey, "Control" }, "r", awesome.restart, { description = "reload awesome", group = "awesome" }),
        awful.key({ modkey, "Shift" }, "q", awesome.quit, { description = "quit awesome", group = "awesome" }),

        --   -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
        -- Layout manipulation
        awful.key({ modkey }, "l", function()
            awful.tag.incmwfact(0.01)
        end, {
            description = "increase master width factor",
            group = "layout",
        }),
        awful.key({ modkey }, "h", function()
            awful.tag.incmwfact(-0.01)
        end, {
            description = "decrease master width factor",
            group = "layout",
        }),
        awful.key({ modkey, "Shift" }, "h", function()
            awful.tag.incnmaster(1, nil, true)
        end, {
            description = "increase the number of master clients",
            group = "layout",
        }),
        awful.key({ modkey, "Shift" }, "l", function()
            awful.tag.incnmaster(-1, nil, true)
        end, {
            description = "decrease the number of master clients",
            group = "layout",
        }),
        awful.key({ modkey, "Control" }, "h", function()
            awful.tag.incncol(1, nil, true)
        end, {
            description = "increase the number of columns",
            group = "layout",
        }),
        awful.key({ modkey, "Control" }, "l", function()
            awful.tag.incncol(-1, nil, true)
        end, {
            description = "decrease the number of columns",
            group = "layout",
        }),
        awful.key({ modkey }, "Tab", function()
            awful.layout.inc(1)
        end, {
            description = "select next",
            group = "layout",
        }),
        awful.key({ modkey, "Shift" }, "Tab", function()
            awful.layout.inc(-1)
        end, {
            description = "select previous",
            group = "layout",
        }),

        awful.key({ modkey, "Control" }, "n", function()
            local c = awful.client.restore()
            -- Focus restored client
            if c then
                c:emit_signal("request::activate", "key.unminimize", { raise = true })
            end
        end, {
            description = "restore minimized",
            group = "client",
        }),

        --   -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
        -- Resize
        --awful.key({ modkey, "Control" }, "Left",  function () awful.client.moveresize( 20,  20, -40, -40) end),
        --awful.key({ modkey, "Control" }, "Right", function () awful.client.moveresize(-20, -20,  40,  40) end),
        awful.key({ modkey, "Control" }, "Down", function()
            awful.client.moveresize(0, 0, 0, -20)
        end),
        awful.key({ modkey, "Control" }, "Up", function()
            awful.client.moveresize(0, 0, 0, 20)
        end),
        awful.key({ modkey, "Control" }, "Left", function()
            awful.client.moveresize(0, 0, -20, 0)
        end),
        awful.key({ modkey, "Control" }, "Right", function()
            awful.client.moveresize(0, 0, 20, 0)
        end),

        -- Move
        awful.key({ modkey, "Shift" }, "Down", function()
            awful.client.moveresize(0, 20, 0, 0)
        end),
        awful.key({ modkey, "Shift" }, "Up", function()
            awful.client.moveresize(0, -20, 0, 0)
        end),
        awful.key({ modkey, "Shift" }, "Left", function()
            awful.client.moveresize(-20, 0, 0, 0)
        end),
        awful.key({ modkey, "Shift" }, "Right", function()
            awful.client.moveresize(20, 0, 0, 0)
        end)
    )

    return globalkeys
end

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

return setmetatable({}, {
    __call = function(_, ...)
        return _M.get(...)
    end,
})
