local vector3 = require('src.vector3')

local geometry = {}

---@return vector3, number
---@param planePos vector3
---@param planeNormal vector3
---@param lineStart vector3
---@param lineEnd vector3
function geometry.intersect_plane(planePos, planeNormal, lineStart, lineEnd)
    planeNormal = planeNormal:normalize()
    local plane_d = -vector3.dot_product(planeNormal, planePos)
    local ad = vector3.dot_product(lineStart, planeNormal)
    local bd = vector3.dot_product(lineEnd, planeNormal)
    local t = (-plane_d - ad) / (bd - ad)
    local lineStartToEnd = lineEnd - lineStart
    local lineToInstsect = lineStartToEnd * t
    return (lineStart + lineToInstsect), t
end

return geometry