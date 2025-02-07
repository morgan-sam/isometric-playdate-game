import "CoreLibs/graphics"
import "CoreLibs/crank"

local gfx <const> = playdate.graphics

local MIN_X = 0
local MAX_X = 399
local MIN_Y = 0
local MAX_Y = 239

-- Add spacing control variables
local baseSpacing = 10
local currentSpacing = baseSpacing
local MIN_SPACING = 5   -- Maximum zoom in
local MAX_SPACING = 30  -- Maximum zoom out
local ZOOM_SPEED = 0.5  -- Adjust this to control zoom sensitivity

-- Helper function to draw parallel lines at an angle
local function drawParallelLines(startAngle)
    local extendedRange = MAX_X + MAX_Y * 2
    
    -- Calculate precise center
    local centerX = MAX_X / 2
    local centerY = MAX_Y / 2
    
    -- Calculate number of lines needed on each side of center
    local numLines = math.ceil(extendedRange / currentSpacing)
    
    -- Start from center and work outwards
    for i = -numLines, numLines do
        local offset = i * currentSpacing
        
        if startAngle == 10 then
            local startX = offset
            local endX = startX + MAX_X + MAX_Y
            local startY = MAX_Y
            local endY = -MAX_Y
            gfx.drawLine(startX + centerX, startY, endX + centerX, endY)
        else
            local startX = offset
            local endX = startX - (MAX_X + MAX_Y)
            local startY = MAX_Y
            local endY = -MAX_Y
            gfx.drawLine(startX + centerX, startY, endX + centerX, endY)
        end
    end
end

function playdate.update()
    gfx.clear()
    
    -- Handle crank rotation
    local change = playdate.getCrankChange()
    currentSpacing = currentSpacing - (change * ZOOM_SPEED)
    currentSpacing = math.max(MIN_SPACING, math.min(MAX_SPACING, currentSpacing))
    
    -- Draw both sets of parallel lines
    drawParallelLines(10)
    drawParallelLines(170)
end