local colorizer = {}

function colorizer.getColour(index)
    if index == 1 then
        return 0, 255, 0
    else
        return 255, 0, 0
    end
end

return colorizer
