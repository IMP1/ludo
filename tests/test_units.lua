local unit = require 'unit'


-- Unit initialisation
local dist = unit.new(4, "m")
local first_lap = unit.new(5.7, "s")
local second_lap = unit.new(6.3, "s")

-- Unit arithmetic
local total_time = first_lap + second_lap
local average_speed = dist / total_time

assert(total_time.amount == 12 and total_time.dimens["s"] == 1)
print(tostring(dist))
print(tostring(average_speed))

-- Unit comparison
local speed_1 = first_lap / dist
local speed_2 = second_lap / dist

print("speed_1 == speed_2", speed_1 == speed_2)
print(second_lap > first_lap)

-- Unit to number
local time_ratio = second_lap / first_lap

print(time_ratio)

-- Number to unit
local slow_down_rate = time_ratio / (dist * 2)

print(slow_down_rate)

-- Unit exponents

local square = dist ^ 2
local cube_1 = square * dist
local cube_2 = dist ^ 3

print(square)
print(cube_1)
print(cube_2)
print("cube_1 == cube_2", cube_1 == cube_2)
print("cube_1 == square", cube_1 == square)

-- Unit conversion functions

local function celsius_to_farenheit(temp_c)
    local conversion = unit.new(9, "F") / unit.new(5, "C")
    local offset = unit.new(32, "F")
    local result = temp_c * conversion + offset
    return result
end

local function farenheit_to_celsius(temp_f)
    local conversion = unit.new(9, "F") / unit.new(5, "C")
    local offset = unit.new(32, "F")
    local result = (temp_f - offset) / conversion
    return result
end

local temp_in_celsius = unit.new(100, "C")
local temp_in_faren = celsius_to_farenheit(temp_in_celsius)
print(temp_in_celsius, "=", temp_in_faren)
print(temp_in_celsius, "=", farenheit_to_celsius(temp_in_faren))

temp_in_celsius = unit.new(0, "C")
temp_in_faren = celsius_to_farenheit(temp_in_celsius)
print(temp_in_celsius, "=", temp_in_faren)

temp_in_celsius = unit.new(-40, "C")
temp_in_faren = celsius_to_farenheit(temp_in_celsius)
print(temp_in_celsius, "=", temp_in_faren)
