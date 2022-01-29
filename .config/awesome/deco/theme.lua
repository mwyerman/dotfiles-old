local gears = require("gears")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi

theme = {}

local RED = "#f7768e"
local TEAL = "#2ac3de"
local FOREGROUND = "#a9b1d6"
local BACKGROUND = "#1a1b26"
local DISABLED = "#565f89"

theme.font = "FiraCode Nerd Font 8"

theme.bg_normal = BACKGROUND
theme.bg_focus = theme.bg_normal
theme.bg_urgent = theme.bg_normal
theme.bg_minimize = theme.bg_normal
theme.bg_systray = theme.bg_normal

theme.fg_normal = FOREGROUND
theme.fg_focus = TEAL
theme.fg_urgent = RED
theme.fg_minimize = DISABLED

theme.useless_gap = dpi(10)
theme.border_width = dpi(1)
theme.border_normal = BACKGROUND
theme.border_focus = TEAL

local icondir = gears.filesystem.get_configuration_dir() .. "icons/"

theme.menu_launcher = gears.color.recolor_image(icondir .. "arch.svg", TEAL)

return theme
