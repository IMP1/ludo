local sum_type = {}
sum_type.__index = sum_type

function sum_type.new(...)
    local self = {}
    setmetatable(self, sum_type)
    self.options = {...}
    return self
end

return sum_type