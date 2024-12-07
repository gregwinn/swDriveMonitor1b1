-- round a number
function round(number)
    return math.floor(number + 0.5)
end

function roundTo(num, n)
    local multiplier = 10 ^ (n or 0)
    return math.floor(num * multiplier + 0.5) / multiplier
end
