local colorizer = {}

function colorizer.getColour(index)
    -- values are R G B
    -- 1 for 100%, 0.5 for 50%
    if index == 1 then
        return .33, .33, 1
    else
        return 1, .33, .33
    end
end

return colorizer
