local complex = {}
complex.__index = complex

function complex.new(...)
    local self = {}
    setmetatable(self, complex)
    self.dimensions = {}
    for _, unit in pairs({...}) do
        local d = unit:dimensions()
        self.dimensions[d] = unit
    end
    return self
end

function complex.__tostring(self)
    local str = ""
    local first = true
    for _, unit in pairs(self.dimensions) do
        if first then
            first = false
        else
            str = str .. " + "
        end
        str = str .. tostring(unit)
    end
    return str
end

function complex.__unm(self)
    local copy = complex.new()
    for d, unit in pairs(self.dimensions) do
        copy.dimensions[d] = -unit
    end
    copy.simplify = self.simplify
    return copy
end

function complex.__add(self, other)
    local copy = complex.new()
    for d, unit in pairs(self.dimensions) do
        copy.dimensions[d] = unit
    end
    for d, unit in pairs(other.dimensions) do
        copy.dimensions[d] = (copy.dimensions[d] or 0) + unit
    end
    copy.simplify = self.simplify
    return copy
end

function complex.__sub(self, other)
    return self + -other
end

function complex.__mul(self, other)
    local result = complex.new()
    for _, unit_a in pairs(self.dimensions) do
        for _, unit_b in pairs(other.dimensions) do
            local unit = unit_a * unit_b
            local d = unit:dimensions()
            if result.dimensions[d] then
                result.dimensions[d] = result.dimensions[d] + unit
            else
                result.dimensions[d] = unit
            end
        end
    end
    result.simplify = self.simplify
    return result:reduce()
end

function complex:reduce()
    if not self.simplify then
        return self
    end
    local dimensions = {}
    for d, u in pairs(self.dimensions) do
        local unit = self.simplify(u)
        local dimen = unit:dimensions()
        if dimensions[dimen] then
            dimensions[dimen] = dimensions[dimen] + unit
        else
            dimensions[dimen] = unit
        end
    end
    self.dimensions = dimensions
    return self
end

function complex:magnitude()
    local total = 0
    local n = 0
    for _, unit in pairs(self.dimensions) do
        total = total + (unit.amount ^ 2)
    end
    return math.sqrt(total)
end

return complex