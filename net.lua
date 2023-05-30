local lain = require("lain")
local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")
local beautiful = require("beautiful")

local interfaces = { -- Defini aca el nombre que corresponda a cada interfaz
    ethernet = "enp0s31f6",
    wifi = "wlp9s0"
}
-- nmcli -t -f NAME c show --active para sacar el nombre de la red wifi
local ethernet_image = wibox.widget {
    widget = wibox.widget.imagebox,
    image = beautiful.ethernet_icon_off,
    resize = false,
    forced_height = 20,
    forced_width = 20,
}

local wifi_image = wibox.widget {
    widget = wibox.widget.imagebox,
    image = beautiful.wifi_icon_disconected,
    resize = false,
    forced_height = 20,
    forced_width = 20,
}

local net_update_and_wifi_name = lain.widget.net {
    wifi_state = "on",
    ethernet_state = "on",
    timeout = 5,
    settings = function()
        local wifi_found = false
        for k, v in pairs(net_now.devices) do
            if k == interfaces.ethernet then
                --local str = " "
                --for a, b in pairs(interfaces.ethernet) do
                    --str = str.." k=" ..a.tostring().." v="..b.tostring()
                --end
                --widget:set_markup(str)

                if v.ethernet == false then 
                    ethernet_image:set_image(gears.color.recolor_image(beautiful.ethernet_icon_on, beautiful.fg_normal))
                else 
                    ethernet_image:set_image(gears.color.recolor_image(beautiful.ethernet_icon_off, beautiful.fg_normal))
                end
            elseif k == interfaces.wifi then 
                wifi_found = true
                if v.wifi == true then 
                    if v.signal < -83 then
                        wifi_image:set_image(gears.color.recolor_image(beautiful.wifi_icon_25, beautiful.fg_normal))
                    elseif v.signal < -70 then
                        wifi_image:set_image(gears.color.recolor_image(beautiful.wifi_icon_50, beautiful.fg_normal))
                    elseif v.signal < -53 then
                        wifi_image:set_image(gears.color.recolor_image(beautiful.wifi_icon_75, beautiful.fg_normal))
                    elseif v.signal >= -53 then
                        wifi_image:set_image(gears.color.recolor_image(beautiful.wifi_icon_100, beautiful.fg_normal))
                    else
                    end
                    awful.spawn.easy_async_with_shell("nmcli -t -f NAME c show --active", function(stdout)
                        if stdout ~= nil then
                            widget:set_markup(stdout..tostring(v.signal))
                        else
                            widget:set_markup("-")
                        end
                    end)
                else 
                    wifi_image:set_image(gears.color.recolor_image(beautiful.wifi_icon_disconnected, beautiful.fg_normal))
                    --widget:set_markup("-")
                    -- Deberia entrar aca en teoria pero si no se conecta a wifi k == interfaces.wifi nunca es true 
                    -- por lo que entra en not wifi_found, no pasa asi con ethernet
                end
            end
        end
        if not wifi_found then
            wifi_image:set_image(gears.color.recolor_image(beautiful.wifi_icon_disconnected, beautiful.fg_normal))
            widget:set_markup("-")
        end

    end
}

net_widget = wibox.widget {
    layout = wibox.layout.align.horizontal,
    {
        widget = wibox.container.margin,
        ethernet_image,
        margins = 4
    },
    {
        widget = wibox.container.margin,
        wifi_image,
        left = 4,
        top = 4,
        bottom = 4,
    },
    net_update_and_wifi_name,
    -- wifi name widget
}
        
