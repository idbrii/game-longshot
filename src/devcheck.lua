local devcheck = {}

function devcheck.isProduction()
    -- Flip to true to disable debug code.
    return false -- true
end

function devcheck.isDebug()
    return not devcheck.isProduction()
end

function devcheck.getUser()
    return os.getenv('USERNAME') or os.getenv('USER') or 'generic'
end

function devcheck.isDev()
    local user = devcheck.getUser()
    return devcheck.isDebug() and (user == 'David' or user == 'dbriscoe' or user == 'ruy')
end

return devcheck
