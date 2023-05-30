---------------------------
-- Default awesome theme --
---------------------------

local theme_assets = require("beautiful.theme_assets")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi

local gfs = require("gears.filesystem")
local themes_path = gfs.get_themes_dir()

local theme = {}

theme.font          = "Ubuntu 10"

theme.bg_normal     = "#262626"
theme.bg_focus      = "#2e8b57"
theme.bg_urgent     = "#ff0000"
theme.bg_minimize   = "#444444"
theme.bg_systray    = theme.bg_normal
theme.wibar_border  = theme.bg_normal

theme.fg_normal     = "#aaaaaa"
theme.fg_focus      = "#000000"
theme.fg_urgent     = "#ffffff"
theme.fg_minimize   = "#ffffff"
--theme.fg_non_empty  =

theme.useless_gap   = dpi(0)
theme.border_width  = dpi(3)
theme.border_normal = "#000000"
theme.border_focus  = "#535d6c"
theme.border_marked = "#91231c"

--battery
theme.battery_red = "#703008"
theme.battery_yellow  = "#6b620d"

--notifications
theme.notification_max_width = 400
theme.notification_icon_size = 100

theme.clock_color = "#ff0000"
-- There are other variable sets
-- overriding the default one when
-- defined, the sets are:
-- taglist_[bg|fg]_[focus|urgent|occupied|empty|volatile]
-- tasklist_[bg|fg]_[focus|urgent]
-- titlebar_[bg|fg]_[normal|focus]
-- tooltip_[font|opacity|fg_color|bg_color|border_width|border_color]
-- mouse_finder_[color|timeout|animate_timeout|radius|factor]
-- prompt_[fg|bg|fg_cursor|bg_cursor|font]
-- hotkeys_[bg|fg|border_width|border_color|shape|opacity|modifiers_fg|label_bg|label_fg|group_margin|font|description_font]
-- Example:
--theme.taglist_bg_focus = "#ff0000"

-- Variables set for theming notifications:
-- notification_font
-- notification_[bg|fg]
-- notification_[width|height|margin]
-- notification_[border_color|border_width|shape|opacity]

-- Variables set for theming the menu:
-- menu_[bg|fg]_[normal|focus]
-- menu_[border_color|border_width]
theme.menu_submenu_icon = themes_path.."default/submenu.png"
theme.menu_height = dpi(15)
theme.menu_width  = dpi(100)

-- You can add as many variables as
-- you wish and access them by using
-- beautiful.variable in your rc.lua

local icon_path = "/usr/share/icons/Fluent/symbolic/"

-- Define the image to load
theme.volume_icon_muted = icon_path .. "status/audio-volume-muted-symbolic.svg"
theme.volume_icon_low = icon_path .. "status/audio-volume-low-symbolic.svg"
theme.volume_icon_medium = icon_path .. "status/audio-volume-medium-symbolic.svg"
theme.volume_icon_high = icon_path .. "status/audio-volume-medium-symbolic.svg"

-- battery icons
-- requires Fluent icons instaled on icon_path
theme.battery_icon_charging_full= icon_path .. "status/battery-100-charging-symbolic.svg"
theme.battery_icon_charging_80  = icon_path .. "status/battery-080-charging-symbolic.svg"
theme.battery_icon_charging_60  = icon_path .. "status/battery-060-charging-symbolic.svg"
theme.battery_icon_charging_40  = icon_path .. "status/battery-040-charging-symbolic.svg"
theme.battery_icon_charging_20  = icon_path .. "status/battery-020-charging-symbolic.svg"
theme.battery_icon_charging_low = icon_path .. "status/battery-000-charging-symbolic.svg"

theme.battery_icon_full= icon_path .. "status/battery-100-symbolic.svg"
theme.battery_icon_80  = icon_path .. "status/battery-080-symbolic.svg"
theme.battery_icon_60  = icon_path .. "status/battery-060-symbolic.svg"
theme.battery_icon_40  = icon_path .. "status/battery-040-symbolic.svg"
theme.battery_icon_20  = icon_path .. "status/battery-020-symbolic.svg"
theme.battery_icon_low = icon_path .. "status/battery-000-symbolic.svg"

-- net
theme.ethernet_icon_off = icon_path .. "status/network-wired-offline-symbolic.svg"
theme.ethernet_icon_on = icon_path .. "status/network-wired-symbolic.svg"

theme.wifi_icon_disconnected = icon_path .. "status/network-wireless-disconnected-symbolic.svg"
theme.wifi_icon_100 = icon_path .. "status/nm-signal-100-symbolic.svg"
theme.wifi_icon_75 = icon_path .. "status/nm-signal-75-symbolic.svg"
theme.wifi_icon_50 = icon_path .. "status/nm-signal-50-symbolic.svg"
theme.wifi_icon_25 = icon_path .. "status/nm-signal-25-symbolic.svg"
theme.wifi_icon_0 = icon_path .. "status/nm-signal-0-symbolic.svg"

theme.titlebar_close_button_normal = themes_path.."default/titlebar/close_normal.png"
theme.titlebar_close_button_focus  = themes_path.."default/titlebar/close_focus.png"

theme.titlebar_minimize_button_normal = themes_path.."default/titlebar/minimize_normal.png"
theme.titlebar_minimize_button_focus  = themes_path.."default/titlebar/minimize_focus.png"

theme.titlebar_ontop_button_normal_inactive = themes_path.."default/titlebar/ontop_normal_inactive.png"
theme.titlebar_ontop_button_focus_inactive  = themes_path.."default/titlebar/ontop_focus_inactive.png"
theme.titlebar_ontop_button_normal_active = themes_path.."default/titlebar/ontop_normal_active.png"
theme.titlebar_ontop_button_focus_active  = themes_path.."default/titlebar/ontop_focus_active.png"

theme.titlebar_sticky_button_normal_inactive = themes_path.."default/titlebar/sticky_normal_inactive.png"
theme.titlebar_sticky_button_focus_inactive  = themes_path.."default/titlebar/sticky_focus_inactive.png"
theme.titlebar_sticky_button_normal_active = themes_path.."default/titlebar/sticky_normal_active.png"
theme.titlebar_sticky_button_focus_active  = themes_path.."default/titlebar/sticky_focus_active.png"

theme.titlebar_floating_button_normal_inactive = themes_path.."default/titlebar/floating_normal_inactive.png"
theme.titlebar_floating_button_focus_inactive  = themes_path.."default/titlebar/floating_focus_inactive.png"
theme.titlebar_floating_button_normal_active = themes_path.."default/titlebar/floating_normal_active.png"
theme.titlebar_floating_button_focus_active  = themes_path.."default/titlebar/floating_focus_active.png"

theme.titlebar_maximized_button_normal_inactive = themes_path.."default/titlebar/maximized_normal_inactive.png"
theme.titlebar_maximized_button_focus_inactive  = themes_path.."default/titlebar/maximized_focus_inactive.png"
theme.titlebar_maximized_button_normal_active = themes_path.."default/titlebar/maximized_normal_active.png"
theme.titlebar_maximized_button_focus_active  = themes_path.."default/titlebar/maximized_focus_active.png"

theme.wallpaper = "/home/franco/Pictures/Wps/gentoo-cow.png"

-- You can use your own layout icons like this:
theme.layout_fairh = themes_path.."default/layouts/fairhw.png"
theme.layout_fairv = themes_path.."default/layouts/fairvw.png"
theme.layout_floating  = themes_path.."default/layouts/floatingw.png"
theme.layout_magnifier = themes_path.."default/layouts/magnifierw.png"
theme.layout_max = themes_path.."default/layouts/maxw.png"
theme.layout_fullscreen = themes_path.."default/layouts/fullscreenw.png"
theme.layout_tilebottom = themes_path.."default/layouts/tilebottomw.png"
theme.layout_tileleft   = themes_path.."default/layouts/tileleftw.png"
theme.layout_tile = themes_path.."default/layouts/tilew.png"
theme.layout_tiletop = themes_path.."default/layouts/tiletopw.png"
theme.layout_spiral  = themes_path.."default/layouts/spiralw.png"
theme.layout_dwindle = themes_path.."default/layouts/dwindlew.png"
theme.layout_cornernw = themes_path.."default/layouts/cornernww.png"
theme.layout_cornerne = themes_path.."default/layouts/cornernew.png"
theme.layout_cornersw = themes_path.."default/layouts/cornersww.png"
theme.layout_cornerse = themes_path.."default/layouts/cornersew.png"

-- Generate Awesome icon:
theme.awesome_icon = theme_assets.awesome_icon(
    theme.menu_height, theme.bg_focus, theme.fg_focus
)

-- Define the icon theme for application icons. If not set then the icons
-- from /usr/share/icons and /usr/share/icons/hicolor will be used.
theme.icon_theme = nil

return theme

-- vim: filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:textwidth=80
