local rational = {}
rational.__index = rational

local function greatest_common_divisor(num, denom)
    if num == 0 then return denom end
    if denom == 0 then return num end
    if num == denom then
        return num
    end
    if num > denom then
        return greatest_common_divisor(num - denom, denom)
    end
    if denom > num then
        return greatest_common_divisor(num, denom - num)
    end
end

function rational.new(num, denom)
    if denom == 0 then error("Dividing by 0") end
    local self = {}
    setmetatable(self, rational)
    self.numerator = num
    self.denominator = denom
    local gcd = greatest_common_divisor(self.numerator, self.denominator)
    self.numerator = self.numerator / gcd
    self.denominator = self.denominator / gcd
    return self
end

function rational.__tostring(self)
    return tostring(self.numerator) .. "/" .. tostring(self.denominator)
end

function rational.__unm(self)
    return rational.new(-self.numerator, self.denominator)
end

function unit.__add(self, other)
    if getmetatable(other) == rational then
        local denom = self.denominator * other.denominator
        return rational.new(self.numerator * other.denominator + self.denominator * other.numerator, denom)
    end
end

function unit.__sub(self, other)
    return unit.__add(self, -other)
end

function unit.__mul(self, other)
    return rational.new(self.numerator * other.numerator, self.denominator * other.denominator)
end

function unit.__div(self, other)
    if getmetatable(other) == rational then
        return rational.new(self.numerator * other.denominator, self.denominator * other.numerator)
    end
end

function unit.__mod(self, other)
    return unit.to_real(self) % unit.to_real(other)
end

function unit.__pow(self, exponent)
    return unit.to_real(self) ^ unit.to_real(other)
end

function unit.__eq(self, other)
    if self.numerator == other.numerator and self.denominator == other.denominator then
        return true
    end
    return unit.to_real(self) == unit.to_real(other)
end

function unit.__le(self, other)
    return unit.to_real(self) <= unit.to_real(other)
end

function unit.__lt(self, other)
    return unit.to_real(self) < unit.to_real(other)
end

function unit.floor(self)
    return math.floor(self:to_real())
end

function unit.to_real(self)
    return self.numerator / self.denominator
end

return rational