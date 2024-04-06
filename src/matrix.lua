---@class matrix4x4

local vector3 = require('src.vector3')

---@return matrix4x4
local function create_new_matrix()
    local matrix = {
        {0, 0, 0, 0},
        {0, 0, 0, 0},
        {0, 0, 0, 0},
        {0, 0, 0, 0}
    }

    return matrix
end

---@return matrix4x4
---@param self matrix4x4
function quick_inverse_matrix(self)
    local matrix = create_new_matrix()

    matrix[1][1] = self[1][1];  matrix[1][2] = self[2][1];  matrix[1][3] = self[3][1];  matrix[1][4] = 0;
    matrix[2][1] = self[1][2];  matrix[2][2] = self[2][2];  matrix[2][3] = self[3][2];  matrix[2][4] = 0;
    matrix[3][1] = self[1][3];  matrix[3][2] = self[2][3];  matrix[3][3] = self[3][3];  matrix[3][4] = 0;

    matrix[4][1] = -(self[4][1] * matrix[1][1] + self[4][2] * matrix[2][1] + self[4][3] * matrix[3][1])
    matrix[4][2] = -(self[4][1] * matrix[1][2] + self[4][2] * matrix[2][2] + self[4][3] * matrix[3][2])
    matrix[4][3] = -(self[4][1] * matrix[1][3] + self[4][2] * matrix[2][3] + self[4][3] * matrix[3][3])
    matrix[4][4] = 1

    return matrix
end

---@return matrix4x4
---@param pos vector3
---@param target vector3
---@param up vector3
function create_point_at_matrix(pos, target, up)
    local newForward = target - pos
    newForward = newForward:normalize()

    local a = newForward * vector3.dot_product(up, newForward)
    local newUp = up - a
    newUp = newUp:normalize()

    local newRight = vector3.cross_product(newUp, newForward)

    local matrix = {
        {newRight.x,   newRight.y,   newRight.z,   0},
        {newUp.x,      newUp.y,      newUp.z,      0},
        {newForward.x, newForward.y, newForward.z, 0},
        {pos.x,        pos.y,        pos.z,        1}
    }

    return matrix
end

---@return matrix4x4
function create_translation_matrix(tx, ty, tz)
    local matrix = {
        {1,  0,  0,  0 },
        {0,  1,  0,  0 },
        {0,  0,  1,  0 },
        {tx, ty, tz, 1 }
    }

    return matrix
end

---@return matrix4x4
function create_scale_matrix(sx, sy, sz)
    local matrix = {
        {sx , 0 , 0 , 0 },
        {0  , sy, 0 , 0 },
        {0  , 0 , sz, 0 },
        {0  , 0 , 0 , 1 }
    }

    return matrix
end

---@return matrix4x4
function create_x_rotation_matrix(a)
    local matrix = {
        {1, 0,            0,           0 },
        {0, math.cos(a),  math.sin(a), 0 },
        {0, -math.sin(a), math.cos(a), 0 },
        {0, 0,            0,           1 }
    }

    return matrix
end

---@return matrix4x4
function create_y_rotation_matrix(a)
    local matrix = {
        {math.cos(a),   0, math.sin(a), 0},
        {0,             1, 0,           0},
        {-math.sin(a),  0, math.cos(a), 0},
        {0,             0, 0,           1}
    }

    return matrix
end

---@return matrix4x4
function create_z_rotation_matrix(a)
    local matrix = {
        {math.cos(a),   math.sin(a),  0, 0},
        {-math.sin(a),  math.cos(a),  0, 0},
        {0,             0,            1, 0},
        {0,             0,            0, 1}
    }

    return matrix
end

---@return matrix4x4
function create_perspective_projection_matrix(fovDeg, aspect, near, far)
    local fovRad = math.rad(fovDeg)

    local matrix = {
        {aspect * fovRad, 0,      0,                            0},
        {0,               fovRad, 0,                            0},
        {0,               0,      far / (far - near),           1},
        {0,               0,      (-far * near) / (far - near), 0}
    }

    return matrix
end


---@return matrix4x4
---@param a matrix4x4
---@param b matrix4x4 
function matrix_multiply(a, b)
    local matrix = create_new_matrix()

    for r = 1, 4, 1 do
        for c = 1, 4, 1 do
            matrix[r][c] = a[r][1] * b[1][c] +
                           a[r][2] * b[2][c] +
                           a[r][3] * b[3][c] +
                           a[r][4] * b[4][c]
        end
    end

    return matrix
end

---@return vector3
---@param matrix matrix4x4
---@param vector vector3
function matrix_multiply_vector(matrix, vector)
    local output = vector3.new(0,0,0);
    output.x = vector.x * matrix[1][1] + vector.y * matrix[2][1] + vector.z * matrix[3][1] + matrix[4][1]
    output.y = vector.x * matrix[1][2] + vector.y * matrix[2][2] + vector.z * matrix[3][2] + matrix[4][2]
    output.z = vector.x * matrix[1][3] + vector.y * matrix[2][3] + vector.z * matrix[3][3] + matrix[4][3]

    return output
end

function matrix_multiply_vector_normalized(matrix, vector)
    local output = vector3.new(0,0,0);
    output.x = vector.x * matrix[1][1] + vector.y * matrix[2][1] + vector.z * matrix[3][1] + matrix[4][1]
    output.y = vector.x * matrix[1][2] + vector.y * matrix[2][2] + vector.z * matrix[3][2] + matrix[4][2]
    output.z = vector.x * matrix[1][3] + vector.y * matrix[2][3] + vector.z * matrix[3][3] + matrix[4][3]
    local w  = vector.x * matrix[1][4] + vector.y * matrix[2][4] + vector.z * matrix[3][4] + matrix[4][4]

    if w ~= 0 then
        output = output / w
    end

    return output
end