import "CoreLibs/graphics"

local gfx <const> = playdate.graphics

local MIN_X = 0
local MAX_X = 399
local MIN_Y = 0
local MAX_Y = 239

-- Helper function to draw parallel lines at an angle
local function drawParallelLines(startAngle)
    local spacing = 10  -- Keeping the same density
    
    -- Extend the range to ensure corner coverage
    local extendedRange = MAX_X + MAX_Y * 2  -- Increased range to cover corners
    
    for offset = -extendedRange, extendedRange, spacing do
        if startAngle == 10 then
            -- Very acute angle (approximately 10 degrees)
            local startX = offset
            local endX = startX + MAX_X + MAX_Y  -- Extended length
            local startY = MAX_Y
            local endY = -MAX_Y  -- Extended upward
            gfx.drawLine(startX, startY, endX, endY)
        else
            -- Mirror angle (approximately 170 degrees)
            local startX = offset
            local endX = startX - (MAX_X + MAX_Y)  -- Extended length
            local startY = MAX_Y
            local endY = -MAX_Y  -- Extended upward
            gfx.drawLine(startX, startY, endX, endY)
        end
    end
end

function playdate.update()
    gfx.clear()
    
    -- Draw both sets of parallel lines
    drawParallelLines(10)    -- Very acute angle
    drawParallelLines(170)   -- Mirrored angle
end