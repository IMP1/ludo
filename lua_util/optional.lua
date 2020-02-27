local optional = {}
optional.__index = optional

function optional.new(value)
    local self = {}
    setmetatable(self, optional)
    self.value = value
    return self
end

function optional:has_value()
    return self.value ~= nil
end

function optional:with(block, else_block)
    if self.value ~= nil then
        block(self.value)
    elseif else_block then
        else_block()
    end
end

return optional
