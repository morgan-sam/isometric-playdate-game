import "CoreLibs/graphics"

local gfx <const> = playdate.graphics

local MIN_X = 0
local MAX_X = 399  -- (400-1)
local MIN_Y = 0
local MAX_Y = 239  -- (240-1)

function playdate.update()
    gfx.clear();
    for i = 0, 19, 1 do
        gfx.drawLine(MIN_X + (i * 2), MIN_Y, MAX_X + (i * 20), MAX_Y);
        -- 
    end
end
