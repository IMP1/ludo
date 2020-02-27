local enum = {}
enum.__index = enum

function enum.new(options)
    local self = {}
    setmetatable(self, enum)
    self.options = options
    return self
end

return enum