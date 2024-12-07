function speedDisplay(menuWidth, speedMPH, engRPS)
    sColor(COLOR_lightGreen)
    if speedMPH < 10 then
        screen.drawText(menuWidth + 12, 8, speedMPH)
    elseif speedMPH < 100 then
        screen.drawText(menuWidth + 10, 8, speedMPH)
    else
        screen.drawText(menuWidth + 7, 8, speedMPH)
    end
    screen.drawText(menuWidth + 7, 15, "MPH")

    -- draw vertical bar showing RPS
    sColor(COLOR_lightGreen)
    screen.drawRectF(menuWidth + 1, 4, 4, 24)

    if engRPS > 20 then
        sColor(COLOR_errorRed)
    else
        sColor(COLOR_darkGreen)
    end

    -- Ensure input is clamped between 0 and maxInput
    local clampedValue = math.max(0, math.min(engRPS, 20))
    -- Calculate the length of the bar
    local barLevel = round(22 - ((clampedValue / 20) * 22))
    screen.drawLine(menuWidth + 2, 27, menuWidth + 2, barLevel + 5)
    screen.drawLine(menuWidth + 3, 27, menuWidth + 3, barLevel + 5)
end