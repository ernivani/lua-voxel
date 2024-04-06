---@class triangle
---@field points table<vector3>
---@field color color

require('src.debug')
local vector3 = require('src.vector3')
local geometry = require('src.geometry')
local c = require('src.color')
local matrix = require('src.matrix')

local triangle = {}
triangle.__index = triangle



local z = 100

---@return triangle
---@param p1 vector3
---@param p2 vector3
---@param p3 vector3
---@param color color
function triangle.new(p1,p2,p3, color)
    local self = setmetatable({}, triangle)


    self.points = {p1, p2, p3}
    self.color = color

    return self
end

---@return triangle
---@param t triangle
function triangle.copy(t)
    local self = setmetatable({}, triangle)


    self.points = {vector3.copy(t.points[1]), vector3.copy(t.points[2]), vector3.copy(t.points[3])}
    self.color = c.new(t.color.r, t.color.g, t.color.b)

    return self
end


---@return triangle
function triangle.newDefault()
    local self = setmetatable({}, triangle)


    self.points = {}
    self.color = c.white

    return self
end

---@param planePos vector3
---@param planeNormal vector3
function triangle:clip_against_plane(planePos, planeNormal)
    local outTri1 = triangle.newDefault()
    local outTri2 = triangle.newDefault()
    
    planeNormal = planeNormal:normalize()

    local function dist(p)
        return planeNormal.x * p.x + planeNormal.y * p.y + planeNormal.z * p.z - vector3.dot_product(planeNormal, planePos)
    end
    
    ---@type table<number, vector3>
    local insidePoints = {}
    local insidePointsCount = 0
    ---@type table<number, vector3>
    local outsidePoints = {}
    local outsidePointsCount = 0

    -- TODO: Texture

    ---@type table<number, number>
    local distances = {}

    distances[1] = dist(self.points[1])
    distances[2] = dist(self.points[2])
    distances[3] = dist(self.points[3])

    for i = 1, 3, 1 do
        if distances[i] >= 0 then
            insidePointsCount = insidePointsCount + 1
            insidePoints[insidePointsCount] = self.points[i]
        else
            outsidePointsCount = outsidePointsCount + 1
            outsidePoints[outsidePointsCount] = self.points[i]
        end
    end

    if insidePointsCount == 0 then
        return 0
    end

    if insidePointsCount == 3 then
        outTri1 = triangle.copy(self)
        return 1, outTri1
    end

    if insidePointsCount == 1 and outsidePointsCount == 2 then
        outTri1.color = self.color

        outTri1.points[1] = insidePoints[1]

        local outPoint2, t = geometry.intersect_plane(planePos, planeNormal, insidePoints[1], outsidePoints[1])
        outTri1.points[2] = outPoint2

        local outPoint3, t = geometry.intersect_plane(planePos, planeNormal, insidePoints[1], outsidePoints[2])
        outTri1.points[3] = outPoint3

        return 1, outTri1
    end

    if(insidePointsCount == 2 and outsidePointsCount == 1) then
        outTri1.color = self.color
        outTri2.color = self.color

        outTri1.points[1] = insidePoints[1]
        outTri1.points[2] = insidePoints[2]
        outTri1.points[3] = geometry.intersect_plane(planePos, planeNormal, insidePoints[1], outsidePoints[1])

        outTri2.points[1] = insidePoints[2]
        outTri2.points[2] = vector3.copy(outTri1.points[3])
        outTri2.points[3] = geometry.intersect_plane(planePos, planeNormal, insidePoints[2], outsidePoints[1])

        return 2, outTri1, outTri2
    end

    return 0
end

---@return vector3
function triangle:normal()
    local a = self.points[1] - self.points[2]
    local b = self.points[1] - self.points[3]

    return vector3.cross_product(a, b):normalize()
end

function triangle:draw()
    love.graphics.setColor(self.color.r, self.color.g, self.color.b)

    love.graphics.polygon(
        'fill',
        self.points[1].x, self.points[1].y,
        self.points[2].x, self.points[2].y,
        self.points[3].x, self.points[3].y
    )
end

---@return triangle
---@param m matrix4x4
function triangle:multiplyByMatrix(m)
    return triangle.new(
        matrix_multiply_vector(m, self.points[1]),
        matrix_multiply_vector(m, self.points[2]),
        matrix_multiply_vector(m, self.points[3]),
        self.color
    )
end

---@return triangle
---@param m matrix4x4
function triangle:multiplyByMatrixNormalized(m)
    return triangle.new(
        matrix_multiply_vector_normalized(m, self.points[1]),
        matrix_multiply_vector_normalized(m, self.points[2]),
        matrix_multiply_vector_normalized(m, self.points[3]),
        self.color
    )
end



return triangle