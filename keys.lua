local gears = require("gears")
local awful = require("awful")
local beautiful = require("beautiful")
local naughty = require("naughty")
local menubar = require("menubar")
local hotkeys_popup = require("awful.hotkeys_popup")

-- This is used later as the default terminal and editor to run.
terminal = "urxvt"
editor = os.getenv("EDITOR") or "vim"
editor_cmd = terminal .. " -e " .. editor
awful.menu.menu_keys.up = { "k" }
awful.menu.menu_keys.down = { "j" }
menu_coords = {coords = {x = 0, y = 0}}
screenshot_dir = "/home/franco/Pictures/Screenshots/"
screenshot_s = "screenshot-.png" -- sacar string con output de date
modkey = "Mod4"

power_menu_table = {
    {
        "Suspend",
        function () awful.spawn("loginctl suspend") end
    },
    {
        "Reboot",
        function () awful.spawn("loginctl reboot") end
    },
    {
        "Power Off",
        function () awful.spawn("loginctl poweroff") end
    },
    {
        "Hibernate",
        function () awful.spawn("loginctl hibernate") end
    }
}

clientbuttons = gears.table.join(
    awful.button({ }, 1, function (c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
    end),
    awful.button({ modkey }, 1, function (c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
        awful.mouse.client.move(c)
    end),
    awful.button({ modkey }, 3, function (c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
        awful.mouse.client.resize(c)
    end)
)

-- {{{ Key bindings
globalkeys = gears.table.join(
    awful.key({ modkey,           }, "s",      hotkeys_popup.show_help,
              {description="show help", group="awesome"}),
    awful.key({ modkey,           }, "Escape", awful.tag.history.restore,
              {description = "go back", group = "tag"}),

    awful.key({ modkey,           }, "j",
        function ()
            awful.client.focus.byidx( 1)
        end,
        {description = "focus next by index", group = "client"}
    ),
    awful.key({ modkey,           }, "k",
        function ()
            awful.client.focus.byidx(-1)
        end,
        {description = "focus previous by index", group = "client"}
    ),

    -- Layout manipulation
    awful.key({ modkey, "Shift"   }, "j", function () awful.client.swap.byidx(  1)    end,
              {description = "swap with next client by index", group = "client"}),
    awful.key({ modkey, "Shift"   }, "k", function () awful.client.swap.byidx( -1)    end,
              {description = "swap with previous client by index", group = "client"}),
    awful.key({ modkey, "Control" }, "j", function () awful.screen.focus_relative( 1) end,
              {description = "focus the next screen", group = "screen"}),
    awful.key({ modkey, "Control" }, "k", function () awful.screen.focus_relative(-1) end,
              {description = "focus the previous screen", group = "screen"}),
    awful.key({ modkey,           }, "u", awful.client.urgent.jumpto,
              {description = "jump to urgent client", group = "client"}),
    awful.key({ modkey,           }, "Tab",
        function ()
            awful.client.focus.history.previous()
            if client.focus then
                client.focus:raise()
            end
        end,
        {description = "go back", group = "client"}),

    -- Standard program
    awful.key({ modkey,           }, "Return", function () awful.spawn(terminal) end,
              {description = "open a terminal", group = "launcher"}),
    awful.key({ modkey, "Control" }, "r", awesome.restart,
              {description = "reload awesome", group = "awesome"}),
    awful.key({ modkey, "Shift"   }, "q", awesome.quit,
              {description = "quit awesome", group = "awesome"}),

    awful.key({ modkey,           }, "l",     function () awful.tag.incmwfact( 0.05)          end,
              {description = "increase master width factor", group = "layout"}),
    awful.key({ modkey,           }, "h",     function () awful.tag.incmwfact(-0.05)          end,
              {description = "decrease master width factor", group = "layout"}),
    awful.key({ modkey, "Shift"   }, "h",     function () awful.tag.incnmaster( 1, nil, true) end,
              {description = "increase the number of master clients", group = "layout"}),
    awful.key({ modkey, "Shift"   }, "l",     function () awful.tag.incnmaster(-1, nil, true) end,
              {description = "decrease the number of master clients", group = "layout"}),
    awful.key({ modkey, "Control" }, "h",     function () awful.tag.incncol( 1, nil, true)    end,
              {description = "increase the number of columns", group = "layout"}),
    awful.key({ modkey, "Control" }, "l",     function () awful.tag.incncol(-1, nil, true)    end,
              {description = "decrease the number of columns", group = "layout"}),
    awful.key({ modkey,           }, "space", function () awful.layout.inc( 1)                end,
              {description = "select next", group = "layout"}),
    awful.key({ modkey, "Shift"   }, "space", function () awful.layout.inc(-1)                end,
              {description = "select previous", group = "layout"}),

    -- Lo mio
    awful.key({ modkey }, "p", function() menubar.show() end,
              {description = "open menubar", group = "launcher"}),

    awful.key({ modkey, "Shift" }, "n", function() awful.spawn.with_line_callback("/home/franco/bin/pvol",
        { exit = function() volume_timer:emit_signal("timeout") end}) end,
                {description = "change pulseaudio sink", group = "sound"}),

    awful.key({ modkey }, "Up", function() awful.spawn.with_line_callback("pactl set-sink-volume \
        @DEFAULT_SINK@ +10%",
        { exit = function() volume_timer:emit_signal("timeout") end}) end,
                {description = "volume up", group = "sound"}),

    awful.key({ modkey }, "Down", function() awful.spawn.with_line_callback("pactl set-sink-volume \
        @DEFAULT_SINK@ -10%",
        { exit = function() volume_timer:emit_signal("timeout") end}) end,
                {description = "volume down", group = "sound"}),
    awful.key({ modkey }, "Print", function() awful.spawn("import "  .. screenshot_dir .. screenshot_s) end,
                {description = "area screenshot", group = "screenshots"}),

    awful.key({ modkey, "Shift" }, "Print", function() awful.spawn("import -window root "  .. screenshot_dir .. screenshot_s) end,
                {description = "area screenshot", group = "screenshots"}),

    awful.key({ modkey }, "w", function() awful.spawn(terminal .. " -e ranger") end,
                {description = "open ranger", group = "launcher"}),

    awful.key({ modkey }, "b", function() for s in screen do
            s.mywibox.visible = not s.mywibox.visible
        end
    end,        {description = "toggle wibar", group = "awesome"}),

    awful.key({ modkey, "Shift" }, "p", function() awful.spawn("playerctl -p spotify play-pause")
    end,        {description = "play-pause spotify", group = "media"}),

    awful.key({ modkey }, "Right", function() awful.spawn("playerctl -p spotify next")
    end,        {description = "spotify next track", group = "media"}),
    
    awful.key({ modkey }, "Left", function() awful.spawn("playerctl -p spotify previous")
    end,        {description = "spotify previous track", group = "media"}),

    awful.key({  }, "XF86MonBrightnessDown", function() awful.spawn("xbacklight -dec 10")
    end,        {description = "Brightness -10%", group = "brightness"}),

    awful.key({  }, "XF86MonBrightnessUp", function() awful.spawn("xbacklight -inc 10")
    end,        {description = "Brightness k10%", group = "brightness"}),

    awful.key({ modkey }, "x", function() awful.menu(power_menu_table):show(menu_coords)
    end,        {description = "quit menu", group = "launcher"})
)

clientkeys = gears.table.join(
    awful.key({ modkey,           }, "f",
        function (c)
            c.fullscreen = not c.fullscreen
            c:raise()
        end,
        {description = "toggle fullscreen", group = "client"}),
    awful.key({ modkey, "Shift"   }, "c",      function (c) c:kill()                         end,
              {description = "close", group = "client"}),
    awful.key({ modkey, "Control" }, "space",  awful.client.floating.toggle                     ,
              {description = "toggle floating", group = "client"}),
    awful.key({ modkey, "Control" }, "Return", function (c) c:swap(awful.client.getmaster()) end,
              {description = "move to master", group = "client"}),
    awful.key({ modkey,           }, "o",      function (c) c:move_to_screen()               end,
              {description = "move to screen", group = "client"}),
    awful.key({ modkey,           }, "t",      function (c) c.ontop = not c.ontop            end,
              {description = "toggle keep on top", group = "client"}),
    awful.key({ modkey,           }, "m",
        function (c)
            c.maximized = not c.maximized
            c:raise()
        end ,
        {description = "(un)maximize", group = "client"}),
    awful.key({ modkey, "Control" }, "m",
        function (c)
            c.maximized_vertical = not c.maximized_vertical
            c:raise()
        end ,
        {description = "(un)maximize vertically", group = "client"}),
    awful.key({ modkey, "Shift"   }, "m",
        function (c)
            c.maximized_horizontal = not c.maximized_horizontal
            c:raise()
        end ,
        {description = "(un)maximize horizontally", group = "client"})
)

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it work on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 9 do
    globalkeys = gears.table.join(globalkeys,
        -- View tag only.
        awful.key({ modkey }, "#" .. i + 9,
                  function ()
                        local screen = awful.screen.focused()
                        local tag = screen.tags[i]
                        if tag then
                           tag:view_only()
                        end
                  end,
                  {description = "view tag #"..i, group = "tag"}),
        -- Toggle tag display.
        awful.key({ modkey, "Control" }, "#" .. i + 9,
                  function ()
                      local screen = awful.screen.focused()
                      local tag = screen.tags[i]
                      if tag then
                         awful.tag.viewtoggle(tag)
                      end
                  end,
                  {description = "toggle tag #" .. i, group = "tag"}),
        -- Move client to tag.
        awful.key({ modkey, "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus then
                          local tag = client.focus.screen.tags[i]
                          if tag then
                              client.focus:move_to_tag(tag)
                          end
                     end
                  end,
                  {description = "move focused client to tag #"..i, group = "tag"}),
        -- Toggle tag on focused client.
        awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus then
                          local tag = client.focus.screen.tags[i]
                          if tag then
                              client.focus:toggle_tag(tag)
                          end
                      end
                  end,
                  {description = "toggle focused client on tag #" .. i, group = "tag"})
    )
end


