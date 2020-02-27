local optional = require 'optional'

local a = optional.new(1337)
a:with(function(b)
    print("Not null")
    print(b)
end)

local c = optional.new(nil)
c:with(function(d)
    print("Not null")
    print(d)
end)

local e = optional.new(nil)
e:with(function(f)
    print("Not null")
    print(f)
end, function()
    print("Null... :(")
end)