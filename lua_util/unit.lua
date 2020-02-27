local unit = {}
unit.__index = unit

function unit.new(amount, ...)
    local self = {}
    setmetatable(self, unit)
    self.amount = amount
    self.dimens = {}
    for _, dimen in pairs({...}) do
        self.dimens[dimen] = 1
    end
    return self
end

function unit.__tostring(self)
    local str = tostring(self.amount)
    str = str .. "::"
    str = str .. self:dimensions()
    return str
end

function unit.dimensions(self)
    local str = ""
    local first = true
    for dimen, power in pairs(self.dimens) do
        if first then
            first = false
        else
            str = str .. "."
        end
        str = str .. dimen
        if power ~= 1 then
            str = str .. "^" .. power
        end
    end
    return str
end

function unit.__unm(self)
    local amount = -self.amount
    local result = unit.new(amount)
    for dimen, power in pairs(self.dimens) do
        result.dimens[dimen] = power
    end
    return result
end

function unit.__add(self, other)
    for dimen, power in pairs(self.dimens) do
        if not other.dimens[dimen] then
            error("attempt to perform arithmetic on different unit values")
        end
    end
    for dimen, power in pairs(other.dimens) do
        if not self.dimens[dimen] then
            error("attempt to perform arithmetic on different unit values")
        end
    end
    local amount = self.amount + other.amount
    local result = unit.new(amount)
    for dimen, power in pairs(self.dimens) do
        result.dimens[dimen] = power
    end
    return result
end

function unit.__sub(self, other)
    for dimen, power in pairs(self.dimens) do
        if not other.dimens[dimen] then
            error("attempt to perform arithmetic on different unit values")
        end
    end
    for dimen, power in pairs(other.dimens) do
        if not self.dimens[dimen] then
            error("attempt to perform arithmetic on different unit values")
        end
    end
    local amount = self.amount - other.amount
    local result = unit.new(amount)
    for dimen, power in pairs(self.dimens) do
        result.dimens[dimen] = power
    end
    return result
end

function unit.__mul(self, other)
    local op1 = self
    if getmetatable(self) == unit then
        op1 = self.amount
    end
    local op2 = other
    if getmetatable(other) == unit then
        op2 = other.amount
    end
    local amount = op1 * op2
    local result = unit.new(amount)
    local dimens = {}
    if getmetatable(self) == unit then
        for dimen, power in pairs(self.dimens) do
            dimens[dimen] = power
        end
    end
    if getmetatable(other) == unit then
        for dimen, power in pairs(other.dimens) do
            new_power = (dimens[dimen] or 0) + power
            dimens[dimen] = new_power
        end
    end
    local dimensionful = false
    for k, v in pairs(dimens) do
        if v ~= 0 then
            result.dimens[k] = v
            dimensionful = true
        end
    end
    if not dimensionful then
        return amount
    end
    return result
end

function unit.__div(self, other)
    local num = self
    if getmetatable(self) == unit then
        num = self.amount
    end
    local denom = other
    if getmetatable(other) == unit then
        denom = other.amount
    end
    local amount = num / denom
    local result = unit.new(amount)
    local dimens = {}
    if getmetatable(self) == unit then
        for dimen, power in pairs(self.dimens) do
            dimens[dimen] = power
        end
    end
    if getmetatable(other) == unit then
        dimensionful = false
        for dimen, power in pairs(other.dimens) do
            new_power = (dimens[dimen] or 0) - power
            dimens[dimen] = new_power
        end
    end
    local dimensionful = false
    for k, v in pairs(dimens) do
        if v ~= 0 then
            result.dimens[k] = v
            dimensionful = true
        end
    end
    if not dimensionful then
        return amount
    end
    return result
end

function unit.__mod(self, other)
    for dimen, power in pairs(self.dimens) do
        if not other.dimens[dimen] then
            error("attempt to perform arithmetic on different unit values")
        end
    end
    for dimen, power in pairs(other.dimens) do
        if not self.dimens[dimen] then
            error("attempt to perform arithmetic on different unit values")
        end
    end
    local amount = self.amount % other.amount
    local result = unit.new(amount)
    for dimen, power in pairs(self.dimens) do
        result.dimens[dimen] = power
    end
    return result
end

function unit.__pow(self, exponent)
    if type(exponent) ~= "number" then
        error("attempt to perform arithmetic on a non-numeric value")
    end
    local amount = self.amount ^ exponent
    local result = unit.new(amount)
    for dimen, power in pairs(self.dimens) do
        result.dimens[dimen] = power * exponent
    end
    return result
end

function unit.__eq(self, other)
    if getmetatable(self) ~= unit then return false end
    if getmetatable(other) ~= unit then return false end
    if self.amount ~= other.amount then
        return false
    end
    for dimen, power in pairs(self.dimens) do
        if not other.dimens[dimen] then
            return false
        end
    end
    for dimen, power in pairs(other.dimens) do
        if not self.dimens[dimen] then
            return false
        end
    end
    return true
end

function unit.__le(self, other)
    for dimen, power in pairs(self.dimens) do
        if not other.dimens[dimen] then
            error("attempt to perform arithmetic on different unit values")
        end
    end
    for dimen, power in pairs(other.dimens) do
        if not self.dimens[dimen] then
            error("attempt to perform arithmetic on different unit values")
        end
    end
    return self.amount <= other.amount
end

function unit.__lt(self, other)
    for dimen, power in pairs(self.dimens) do
        if not other.dimens[dimen] then
            error("attempt to perform arithmetic on different unit values")
        end
    end
    for dimen, power in pairs(other.dimens) do
        if not self.dimens[dimen] then
            error("attempt to perform arithmetic on different unit values")
        end
    end
    return self.amount < other.amount
end



return unit