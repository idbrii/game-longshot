-- Fake version of devcheck.lua
local devcheck = {}

function devcheck.getUser()
    return ''
end

function devcheck.isDev()
    return false
end

return devcheck
