--- Developed using LifeBoatAPI - Stormworks Lua plugin for VSCode - https://code.visualstudio.com/download (search "Stormworks Lua with LifeboatAPI" extension)
--- If you have any issues, please report them here: https://github.com/nameouschangey/STORMWORKS_VSCodeExtension/issues - by Nameous Changey


--[====[ HOTKEYS ]====]
-- Press F6 to simulate this file
-- Press F7 to build the project, copy the output from /_build/out/ into the game to use
-- Remember to set your Author name etc. in the settings: CTRL+COMMA


--[====[ EDITABLE SIMULATOR CONFIG - *automatically removed from the F7 build output ]====]
---@section __LB_SIMULATOR_ONLY__
do
    ---@type Simulator -- Set properties and screen sizes here - will run once when the script is loaded
    simulator = simulator
    simulator:setScreen(1, "1x1")
    simulator:setProperty("ExampleNumberProperty", 123)

    -- Runs every tick just before onTick; allows you to simulate the inputs changing
    ---@param simulator Simulator Use simulator:<function>() to set inputs etc.
    ---@param ticks     number Number of ticks since simulator started
    function onLBSimulatorTick(simulator, ticks)

        -- touchscreen defaults
        local screenConnection = simulator:getTouchScreen(1)
        simulator:setInputNumber(7, simulator:getSlider(1) * 100)
        simulator:setInputNumber(8, simulator:getSlider(3) * 200)
        simulator:setInputNumber(9, simulator:getSlider(4) * 120)
        simulator:setInputNumber(10, simulator:getSlider(2) * 21)
        -- simulator:setInputNumber(1, screenConnection.width)
        -- simulator:setInputNumber(2, screenConnection.height)
        simulator:setInputNumber(3, screenConnection.touchX)
        simulator:setInputNumber(4, screenConnection.touchY)
        simulator:setInputBool(1, screenConnection.isTouched)

        -- NEW! button/slider options from the UI
        -- simulator:setInputBool(31, simulator:getIsClicked(1))       -- if button 1 is clicked, provide an ON pulse for input.getBool(31)
        -- simulator:setInputNumber(31, simulator:getSlider(1))        -- set input 31 to the value of slider 1

        -- simulator:setInputBool(32, simulator:getIsToggled(2))       -- make button 2 a toggle, for input.getBool(32)
        -- simulator:setInputNumber(32, simulator:getSlider(2) * 50)   -- set input 32 to the value from slider 2 * 50
    end;
end
---@endsection


--[====[ IN-GAME CODE ]====]

-- try require("Folder.Filename") to include code from another file in this, so you can store code in libraries
-- the "LifeBoatAPI" is included by default in /_build/libs/ - you can use require("LifeBoatAPI") to get this, and use all the LifeBoatAPI.<functions>!

-- NOTES: x is left to right, y is top to bottom
-- Very dark green: 21, 38, 29
-- Dark green: 29, 87, 56
-- Light green: 86, 240, 158
-- Error Red: 140, 0, 0
require("Helpers.numbers")
require("Helpers.static")
require("Helpers.speed_display")
require("Helpers.fuel_display")
require("Helpers.engtemp_display")
require("Helpers.rps_display")


ticks = 0
-- Inputs
-- 7: Speed sensor (MPH)
-- 8: Fuel sensor (L)
-- 9: Engine temperature sensor (°C)
-- 10: Engine RPS sensor (RPS)
-- 11: Gear

-- 3: Touch x
-- 4: Touch y
-- 1: Touch state

-- Outputs
-- Video Out


isClicked = false
local speedMenuClicked = false
local fuelMenuClicked = false
local tempMenuClicked = false
local rpsMenuClicked = false
local menuWidth = 8
local lastClickedMenu = 0

-- Temp Display Settings
TEMP_Conversion_selection = 0 -- 0 = C, 1 = F

COLOR_darkGreen = {29, 87, 56}
COLOR_lightGreen = {86, 240, 158}
COLOR_errorRed = {140, 0, 0}
COLOR_veryDarkGreen = {21, 38, 29}
COLOR_lightGray = {156, 156, 156}
COLOR_darkGary = {43, 43, 43}
COLOR_veryDarkGray = {18, 18, 18}

function onTick()
    ticks = ticks + 1
    isClicked = input.getBool(1)

    speedMPH = round(input.getNumber(7) * 2.23694 or 00)
    engRPS = round(input.getNumber(10))
    fuelValue = input.getNumber(8)
    engTemp = roundTo(input.getNumber(9), 1)

    touchX = input.getNumber(3)
    touchY = input.getNumber(4)

    speedMenuClicked = isMenuClicked(1, touchX, touchY)
    fuelMenuClicked = isMenuClicked(4, touchX, touchY)
    tempMenuClicked = isMenuClicked(2, touchX, touchY)
    rpsMenuClicked = isMenuClicked(3, touchX, touchY)
end

function onDraw()
    local w = screen.getWidth()
    local h = screen.getHeight()

    -- Draw the loading screen
    local isLoading = loadingScreen(ticks)

    if not isLoading then
        -- Load Sidebar menu
        menuOption("S", 1) -- Speed
        menuOption("T", 2) -- Temp
        menuOption("R", 3) -- RPS
        menuOption("F", 4) -- Fuel

        -- Draw Info Box background
        sColor(COLOR_veryDarkGreen)
        screen.drawRectF(menuWidth, 0, w - menuWidth, h)

        if speedMenuClicked or lastClickedMenu == 0 then
            lastClickedMenu = 0
            speedDisplay(menuWidth, speedMPH, engRPS)
        end

        if fuelMenuClicked or lastClickedMenu == 4 then
            lastClickedMenu = 4
            fuelDisplay(menuWidth, fuelValue)
        end

        if tempMenuClicked or lastClickedMenu == 2 then
            lastClickedMenu = 2
            engTempDisplay(menuWidth, engTemp)
        end

        if rpsMenuClicked or lastClickedMenu == 3 then
            lastClickedMenu = 3
            rpsDisplay(menuWidth, engRPS)
        end
    end
end



