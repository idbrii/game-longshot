local devcheck = {}

function devcheck.getUser()
    return os.getenv('USERNAME') or os.getenv('USER') or 'generic'
end

function devcheck.isDev()
    local user = devcheck.getUser()
    return user == 'David' or user == 'dbriscoe' or user == 'ruy'
end

return devcheck
