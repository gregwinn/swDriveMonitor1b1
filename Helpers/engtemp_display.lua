function engTempDisplay(menuWidth, engTemp)
    local convertedTemp = engTemp
    sColor(COLOR_lightGreen)
    screen.drawText(menuWidth + 3, 4, "TEMP")

    if TEMP_Conversion_selection == 1 then
        convertedTemp = roundTo((engTemp * 9 / 5) + 32, 1)
    end

    if convertedTemp < 10 then
        screen.drawText(menuWidth + 5, 14, convertedTemp)
    elseif convertedTemp < 100 then
        screen.drawText(menuWidth + 3, 14, convertedTemp)
    else
        screen.drawText(menuWidth + 4, 14, round(convertedTemp))
    end

    sColor(COLOR_veryDarkGray)
    screen.drawLine(menuWidth, 23, menuWidth + 24, 23)

    -- Celcius box
    local cboxClick = isClicked and isItemClicked(menuWidth, 24, 12, 10)
    if cboxClick then
        TEMP_Conversion_selection = 0
    end
    if TEMP_Conversion_selection == 0 then
        -- Selected
        sColor(COLOR_lightGray)
        screen.drawRectF(menuWidth, 24, 12, 10)
        sColor(COLOR_darkGary)
        screen.drawText(menuWidth + 4, 25, "C")
    else
        sColor(COLOR_lightGreen)
        screen.drawRectF(menuWidth, 24, 12, 10)
        sColor(COLOR_darkGreen)
        screen.drawText(menuWidth + 4, 25, "C")
    end

    -- Fahrenheit box
    local fboxClick = isClicked and isItemClicked(menuWidth + 12, 24, 12, 10)
    if fboxClick then
        TEMP_Conversion_selection = 1
    end
    if TEMP_Conversion_selection == 1 then
        -- Selected
        sColor(COLOR_lightGray)
        screen.drawRectF(menuWidth + 12, 24, 12, 10)
        sColor(COLOR_darkGary)
        screen.drawText(menuWidth + 16, 25, "F")
    else
        sColor(COLOR_lightGreen)
        screen.drawRectF(menuWidth + 12, 24, 12, 10)
        sColor(COLOR_darkGreen)
        screen.drawText(menuWidth + 16, 25, "F")
    end
end