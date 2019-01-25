local colorizer = {}

function colorizer.getColour(index)
    -- values are R G B
    -- 1 for 100%, 0.5 for 50%
    if index == 1 then
        return 0, 1, 0
    else
        return 1, 0, 0
    end
end

return colorizer
