local lain = require("lain")
local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")
local beautiful = require("beautiful")

local my_battery_image = wibox.widget {
    image = beautiful.battery_icon_60,
    forced_height = 10,
    forced_width = 20,
    resize = false,
    widget = wibox.widget.imagebox
}
local update_battery_image = function(widget, perc, status)
    --status puede ser N/A, Charging, Discharging o Full
    local im = beautiful.battery_icon_60 
    local color = beautiful.fg_normal

    if (status == "N/A") then
        im = beautiful.battery_icon_low
    elseif (status == "Discharging") then
        if perc == 100 then im = beautiful.battery_icon_full
        elseif perc >= 80 then im = beautiful.battery_icon_80
        elseif perc >= 60 then im = beautiful.battery_icon_60
        elseif perc >= 40 then im = beautiful.battery_icon_40
        elseif perc >= 20 then 
            im = beautiful.battery_icon_20
            color = beautiful.battery_yellow
        else 
            im = beautiful.battery_icon_low
            color = beautiful.battery_red
        end
    else -- Charging o Full
        if perc == 100 then im = beautiful.battery_icon_charging_full
        elseif perc >= 80 then im = beautiful.battery_icon_charging_80
        elseif perc >= 60 then im = beautiful.battery_icon_charging_60
        elseif perc >= 40 then im = beautiful.battery_icon_charging_40
        elseif perc >= 20 then 
            im = beautiful.battery_icon_charging_20
            color = beautiful.battery_yellow
        else 
            im = beautiful.battery_icon_charging_low
            color = beautiful.battery_red
        end
    end
    widget:set_image(gears.color.recolor_image(im, color))
end

local my_battery = lain.widget.bat {
    battery = "BAT0",
    settings = function()
        perc = bat_now.perc .. " "
        status = bat_now.status
        widget:set_markup(bat_now.perc .. "%")
        -- hacer call a funcion de actualizar imagebox
        update_battery_image(my_battery_image, bat_now.perc, bat_now.status)
    end
}

battery_widget = wibox.widget {
    layout = wibox.layout.align.horizontal,
    {
        my_battery_image,
        margins = 4,
        widget = wibox.container.margin
    },
    my_battery,
}
