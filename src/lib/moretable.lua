local moretable = {}

-- Get a table index as if the table were circular.
--
-- You probably want circular_index instead.
-- Due to Lua's 1-based arrays, this is more complex than usual.
function moretable.circular_index_number(count, index)
    local zb_current = index - 1
    local zb_result = zb_current
    zb_result = zb_result % count
    return zb_result + 1
end

-- Index a table as if it were circular.
-- Use like this:
--      next_item = circular_index(item_list, index + 1)
function moretable.circular_index(t, index)
    return t[moretable.circular_index_number(#t, index)]
end

return moretable
