function rpsDisplay(menuWidth, engRPS)
    sColor(COLOR_lightGreen)
    screen.drawText(menuWidth + 7, 10, "RPS")

    if engRPS < 10 then
        screen.drawText(menuWidth + 12, 18, engRPS)
    else
        screen.drawText(menuWidth + 9, 18, engRPS)
    end
    

    -- draw vertical bar showing RPS
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