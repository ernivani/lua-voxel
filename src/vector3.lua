---@class vector3
---@field x number
---@field y number
---@field z number
---@field w number

-- vector metatable:
local vector3 = {}
vector3.__index = vector3

local original_type = type

type = function( obj )
  local otype = original_type( obj )
  if  otype == "table" and getmetatable( obj ) == vector3 then
      return "vector"
  end
  return otype
end


---@return vector3
---@param x number
---@param y number
---@param z number
function vector3.new(x, y, z)
  local self = setmetatable({x = x or 0, y = y or 0, z = z or 0}, vector3)
  self.w = 0
  
  return self
end

---@return vector3
---@param v vector3
function vector3.copy(v)
  local self = setmetatable({x = v.x or 0, y = v.y or 0, z = v.z or 0}, vector3)
  self.w = v.w
  
  return self
end

---@return vector3
---@param a vector3
---@param b vector3
function vector3.cross_product(a, b)
  local nx = a.y * b.z - a.z * b.y
  local ny = a.z * b.x - a.x * b.z
  local nz = a.x * b.y - a.y * b.x

  return vector3.new(nx,ny,nz)
end

---@return number
---@param a vector3
---@param b vector3
function vector3.dot_product(a,b)
  return a.x * b.x + a.y * b.y + a.z * b.z
end

---@return vector3
function vector3:normalize()
  local output = vector3.new(0,0,0)
  local length = self:length()

  output.x = self.x / length
  output.y = self.y / length
  output.z = self.z / length

  return output
end

function vector3:length()
  return math.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
end

-- vector addition:
function vector3.__add(a, b)
  return vector3.new(a.x + b.x, a.y + b.y, a.z + b.z)
end

-- vector subtraction:
function vector3.__sub(a, b)
  return vector3.new(a.x - b.x, a.y - b.y, a.z - b.z)
end

-- multiplication of a vector by a scalar:
function vector3.__mul(a, b)
  if type(a) == "number" then
    return vector3.new(b.x * a, b.y * a, b.z  * a)
  elseif type(b) == "number" then
    return vector3.new(a.x * b, a.y * b, a.z * b)
  else
    error("Can only multiply vector by scalar.")
  end
end

-- dividing a vector by a scalar:
function vector3.__div(a, b)
   if type(b) == "number" then
      return vector3.new(a.x / b, a.y / b, a.z / b)
   else
      error("Invalid argument types for vector division.")
   end
end

-- vector equivalence comparison:
function vector3.__eq(a, b)
	return a.x == b.x and a.y == b.y and a.z == b.z
end

-- vector not equivalence comparison:
function vector3.__ne(a, b)
	return not vector3.__eq(a, b)
end

-- unary negation operator:
function vector3.__unm(a)
	return vector3.new(-a.x, -a.y, -a.z)
end

-- vector < comparison:
function vector3.__lt(a, b)
	 return a.x < b.x and a.y < b.y and a.z < b.z
end

-- vector <= comparison:
function vector3.__le(a, b)
	 return a.x <= b.x and a.y <= b.y and a.z <= b.z
end

-- vector value string output:
function vector3.__tostring(v)
	 return "(" .. v.x .. ", " .. v.y .. ", ".. v.z ..")"
end

return vector3