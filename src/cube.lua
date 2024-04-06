local triangle = require('src.triangle')
local vector3 = require('src.vector3')
local color = require('src.color')

function create_debug_cube()
    local triangles = {}

    -- Left
    table.insert(triangles, triangle.new(
        vector3.new(-1, 1, 1),
        vector3.new(-1, 1, -1),
        vector3.new(-1, -1, -1),
        color.red
    ))
    table.insert(triangles, triangle.new(
        vector3.new(-1, 1, 1),
        vector3.new(-1, -1, -1),
        vector3.new(-1, -1, 1),
        color.green
    ))

    -- Top
    table.insert(triangles, triangle.new(
        vector3.new(-1, -1, 1),
        vector3.new(-1, -1, -1),
        vector3.new(1, -1, -1),
        color.blue
    ))
    table.insert(triangles, triangle.new(
        vector3.new(-1, -1, 1),
        vector3.new(1, -1, -1),
        vector3.new(1, -1, 1),
        color.cyan
    ))

    -- Front
    table.insert(triangles, triangle.new(
        vector3.new(-1, 1, 1),
        vector3.new(-1, -1, 1),
        vector3.new(1, -1, 1),
        color.yellow
    ))
    table.insert(triangles, triangle.new(
        vector3.new(-1, 1, 1),
        vector3.new(1, -1, 1),
        vector3.new(1, 1, 1),
        color.purple
    ))

    -- Back
    table.insert(triangles, triangle.new(
        vector3.new(1, 1, -1),
        vector3.new(-1, -1, -1),
        vector3.new(-1, 1, -1),
        color.pink
    ))
    table.insert(triangles, triangle.new(
        vector3.new(1, 1, -1),
        vector3.new(1, -1, -1),
        vector3.new(-1, -1, -1),
        color.brown
    ))

    -- Right
    table.insert(triangles, triangle.new(
        vector3.new(1, 1, -1),
        vector3.new(1, 1, 1),
        vector3.new(1, -1, 1),
        color.orange
    ))
    table.insert(triangles, triangle.new(
        vector3.new(1, 1, -1),
        vector3.new(1, -1, 1),
        vector3.new(1, -1, -1),
        color.white
    ))

    -- Bottom
    table.insert(triangles, triangle.new(
        vector3.new(-1, 1, -1),
        vector3.new(-1, 1, 1),
        vector3.new(1, 1, 1),
        color.grey
    ))
    table.insert(triangles, triangle.new(
        vector3.new(-1, 1, -1),
        vector3.new(1, 1, 1),
        vector3.new(1, 1, -1),
        color.wheat
    ))

    return triangles
end