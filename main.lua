require('src.matrix')
require('src.cube')

local triangle = require('src.triangle')
local vector3 = require('src.vector3')
local color = require('src.color')

local engine = require('src.engine')

require('src.debug')

local sounds = {}

function love.load()
    love.mouse.setRelativeMode(true)
    -- love.mouse.setVisible(false)
    -- love.mouse.setGrabbed(true)
    love.window.setMode(800,600)
    local width, height = love.graphics.getDimensions()

    engine.setViewSize(width, height)
    engine.loadTriangles(create_debug_cube())

    
    sounds.music = love.audio.newSource("sounds/ambient-piano.mp3", "stream")

    sounds.music:setVolume(0.01)
    --sounds.music:play()
end

function love.update(dt)

    if love.keyboard.isDown('escape') then
        love.window.close()
    end

    local forward = lookDirection * (8 * dt)
    local right = vector3.new(forward.z, 0, -forward.x):normalize() * (8*dt)

    if love.keyboard.isDown('w') then
        engine.moveCamera(forward)
    end

    if love.keyboard.isDown('s') then
        engine.moveCamera(-forward)
    end

    if love.keyboard.isDown('a') then
        engine.moveCamera(-right);
    end

    if love.keyboard.isDown('d') then
        engine.moveCamera(right);
    end

    if love.keyboard.isDown('space') then
        engine.moveCamera(vector3.new(0, 8 * dt, 0))
    end

    if love.keyboard.isDown('lshift') then
        engine.moveCamera(vector3.new(0, -8 * dt, 0))
    end
end

function love.mousemoved(x, y, dx, dy, isTouch)
    engine.turnCamera(-dx * 0.001, dy * 0.001)
end


function love.draw()
    engine.draw()
end
