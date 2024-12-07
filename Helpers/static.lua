function loadingScreen(ticks)
    if ticks < 300 then
        screen.setColor(86, 240, 158)
        screen.drawRectF(0, 0, 32, 32)
        
        -- Loading bar
        screen.setColor(29, 87, 56)
        screen.drawRectF(0, 12, ticks / 300 * 32, 6)

        -- loading text
        screen.drawText(6, 7, "WINN")
        screen.drawText(4, 18, "Drive")

        return true
    end
    return false
end

function menuOption(letter, menuOrder)
    menuOrder = menuOrder - 1
    local x = menuOrder * 8
    local y = menuOrder * 8
    screen.setColor(86, 240, 158)
    screen.drawRectF(0, y, 8, 8)

    screen.setColor(29, 87, 56)
    screen.drawLine(0, y + 7, 8, y + 7)

    sColor(COLOR_veryDarkGray)
    screen.drawText(2, y + 1, letter)
end

function isMenuClicked(menuNumber, touchX, touchY)
    menuNumber = menuNumber - 1
    local x = 0
    local y = menuNumber * 8

    return touchX >= x and touchX <= x + 8 and touchY >= y and touchY <= y + 8 
end

function isItemClicked(x, y, w, h)
    return touchX >= x and touchX <= x + w and touchY >= y and touchY <= y + h
end

function sColor(color)
    local r, g, b = color[1], color[2], color[3]
    screen.setColor(r, g, b)
end