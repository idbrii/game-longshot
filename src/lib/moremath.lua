local moremath = {}

function moremath.isApproxEqual(a, b)
    return math.abs(a - b) < 0.001
end

function moremath.isApproxZero(a)
    return moremath.isApproxEqual(a, 0)
end

return moremath
