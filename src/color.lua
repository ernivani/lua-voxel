---@class color
---@field r number
---@field g number
---@field b number

local color = {}
color.__index = color

---@return color
---@param r number
---@param g number
---@param b number
function color.new(r,g,b)
    local self = setmetatable({}, color)

    self.r = r
    self.g = g
    self.b = b

    return self
end

---@return color
function color.random()
    local self = setmetatable({}, color)

    self.r = math.random()
    self.g = math.random()
    self.b = math.random()

    return self
end

-- color value string output:
function color.__tostring(c)
    return "(" .. c.r .. ", " .. c.g .. ", ".. c.b ..")"
end

---@type color
color.green = color.new(0,1,0)

---@type color
color.blue = color.new(0,0,1)

---@type color
color.red = color.new(1,0,0)

---@type color
color.purple = color.new(1,0,1)

---@type color
color.yellow = color.new(1,1,0)

---@type color
color.cyan = color.new(0,1,1)

---@type color
color.white = color.new(1,1,1)

---@type color
color.grey = color.new(0.75,0.75,0.75)

---@type color
color.orange = color.new(1,0.65,0)

---@type color
color.brown = color.new(0.65,0.16,0.16)

---@type color
color.pink = color.new(1,0.75,0.8)

---@type color
color.wheat = color.new(0.96,0.87,0.7)

return color