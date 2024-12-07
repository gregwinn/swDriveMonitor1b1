function fuelDisplay(menuWidth, fuelValue)
    local fuelLevel = roundTo(fuelValue, 1)
    sColor(COLOR_lightGreen)
    screen.drawText(menuWidth + 3, 4, "FUEL")

    if fuelLevel < 10 then
        screen.drawText(menuWidth + 5, 14, fuelLevel)
    elseif fuelLevel < 100 then
        screen.drawText(menuWidth + 3, 14, fuelLevel)
    else
        screen.drawText(menuWidth + 5, 14, round(fuelLevel))
    end

    screen.drawText(menuWidth + 5, 24, "LTR")
end