local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")
local beautiful = require("beautiful")
local menubar = require("menubar")
local lain = require("lain")
local markup = require("lain.util.markup")
local bat = require("bat")
local net = require("net")


widgets = {}
-- widgets propios para usar en la wibar
volume_widget, volume_timer = awful.widget.watch('/home/franco/bin/wibar_volume', 10)

mylauncher = awful.widget.launcher({ image = beautiful.awesome_icon,
                                     menu = mymainmenu })
-- Volume
local my_volume = wibox.widget {
    {
        {
            widget = wibox.widget.imagebox,
            image = gears.color.recolor_image(beautiful.volume_icon, beautiful.fg_normal),
            resize = true,
        },
        widget = wibox.container.margin,
        left = 3,
        right = 3,
        top = 3,
        bottom = 3,
    },
    { 
        volume_widget,
        width = 200,
        layout = wibox.layout.constraint,
    },
    layout = wibox.layout.fixed.horizontal,
}

-- Menubar configuration
menubar.utils.terminal = terminal -- Set the terminal for applications that require it
-- }}}

-- Keyboard map indicator and switcher
mykeyboardlayout = awful.widget.keyboardlayout()

-- {{{ Wibar
-- Create a textclock widget
local mytextclock = wibox.widget.textclock('<span font="12.5" color="'.. beautiful.clock_color ..'"> %H:%M </span> <span font="9">%a %d %b </span>')

-- Create a wibox for each screen and add it
local taglist_buttons = gears.table.join(
                    awful.button({ }, 1, function(t) t:view_only() end),
                    awful.button({ modkey }, 1, function(t)
                                              if client.focus then
                                                  client.focus:move_to_tag(t)
                                              end
                                          end),
                    awful.button({ }, 3, awful.tag.viewtoggle),
                    awful.button({ modkey }, 3, function(t)
                                              if client.focus then
                                                  client.focus:toggle_tag(t)
                                              end
                                          end),
                    awful.button({ }, 4, function(t) awful.tag.viewnext(t.screen) end),
                    awful.button({ }, 5, function(t) awful.tag.viewprev(t.screen) end)
                )

local tasklist_buttons = gears.table.join(
                     awful.button({ }, 1, function (c)
                                              if c == client.focus then
                                                  c.minimized = true
                                              else
                                                  c:emit_signal(
                                                      "request::activate",
                                                      "tasklist",
                                                      {raise = true}
                                                  )
                                              end
                                          end),
                     awful.button({ }, 3, function()
                                              awful.menu.client_list({ theme = { width = 250 } })
                                          end),
                     awful.button({ }, 4, function ()
                                              awful.client.focus.byidx(1)
                                          end),
                     awful.button({ }, 5, function ()
                                              awful.client.focus.byidx(-1)
                                          end))

local function set_wallpaper(s)
    -- Wallpaper
    if beautiful.wallpaper then
        local wallpaper = beautiful.wallpaper
        -- If wallpaper is a function, call it with the screen
        if type(wallpaper) == "function" then
            wallpaper = wallpaper(s)
        end
        gears.wallpaper.maximized(wallpaper, s, true)
    end
end

-- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
screen.connect_signal("property::geometry", set_wallpaper)

-- }}}

widgets.widget_function = function(s)
    -- Wallpaper
    set_wallpaper(s)

    -- Each screen has its own tag table.
    local names = { "I", "II", "III", "IV", "V" }
    local l = awful.layout.suit
    local layouts = { l.tile, l.tile, l.max, l.tile, l.floating }
    awful.tag(names, s, layouts)

    -- Create a promptbox for each screen
    s.mypromptbox = awful.widget.prompt()
    -- Create an imagebox widget which will contain an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    s.mylayoutbox = awful.widget.layoutbox(s)
    -- Para cambiar layouts con mouse
    --s.mylayoutbox:buttons(gears.table.join(
                           --awful.button({ }, 1, function () awful.layout.inc( 1) end),
                           --awful.button({ }, 3, function () awful.layout.inc(-1) end),
                           --awful.button({ }, 4, function () awful.layout.inc( 1) end),
                           --awful.button({ }, 5, function () awful.layout.inc(-1) end)))
    -- Create a taglist widget 
    s.mytaglist = awful.widget.taglist {
        screen  = s,
        filter  = awful.widget.taglist.filter.all,
        --TODO Pasar a theme todos los colores y cantidades?
        style = {
            fg_occupied = "#fcba03",
        },
        widget_template = {
            id = "background_role",
            widget = wibox.container.background,
            {
                id = "shape_role",
                widget = wibox.container.background,
                {
                    widget = wibox.container.margin,
                    left = 9,
                    right = 9,
                    {
                        id = "text_role",
                        widget = wibox.widget.textbox,
                    }
                }
            }
        }
    }

    -- Create a tasklist widget
    s.mytasklist = awful.widget.tasklist {
        screen  = s,
        filter  = awful.widget.tasklist.filter.focused,
        widget_template = {
            {
                {
                    {
                        id = 'text_role',
                        widget = wibox.widget.textbox,
                    },
                    layout = wibox.layout.fixed.horizontal,
                },
                left = 5,
                right = 5,
                widget = wibox.container.margin,
            },
            id = 'background_role',
            widget = wibox.container.background,
        }
    }

    -- Create the wibox
    s.mywibox = awful.wibar({ 
        position = "top",
        screen = s,
        border_color = beautiful.wibar_border,
        border_width = 2,
        width = s.geometry.width 
        --TODO theme vars
    })

    -- Add widgets to the wibox
    s.mywibox.widget = wibox.widget {
        layout = wibox.layout.align.horizontal,
        expand = "none", -- Widget central fijo, se adaptan los de afuera
        { -- Left widgets
            spacing = 10,
            spacing_widget = {
                widget = wibox.widget.separator,
                color = "#ff0000",
            },
            layout = wibox.layout.fixed.horizontal,
            {
                s.mytaglist,
                widget = wibox.container.margin,
                right = 0,
            },
            battery_widget,
            net_widget,
            { -- Volumen
                widget = wibox.container.margin,
                left = 9,
                right = 9,
                my_volume,
            },
            --s.mypromptbox,
        },
        { -- Middle widget
            layout = wibox.layout.fixed.horizontal,
            mytextclock,
        },
        { -- Right widgets
            layout = wibox.layout.align.horizontal,
            s.mytasklist, 
            s.mylayoutbox,
        },
    }

    --s.mywibox:setup {
    --}
        end

return widgets
