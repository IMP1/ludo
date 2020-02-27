local unit = require 'unit'
local complex = require 'complex'


-- Unit initialisation
local real = unit.new(4, "Re")
local imaginary = unit.new(3, "Im")

local c = complex.new(real, imaginary)

c.simplify = function(unit)
    while unit.dimens["Im"] >= 2 do
        print(unit.dimens["Im"])
        unit.amount = -unit.amount
        unit.dimens["Im"] = unit.dimens["Im"] - 2
    end
end

print(real)
print(imaginary)
print(c)             -- 4 + 3i
print(-c)            -- -4 + -3i
print(c:magnitude()) -- 5
print(c * c)         -- 7 + 24i
