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

-- Append one table's values into another, but recursively so tables with the
-- same key are merged.
--
-- Maintains list indexes from first table and appends the second.
-- Number keys are always assumed to be indexes and are appended (tables
-- indexed by number won't be merged).
function moretable.append_recursive(target, other)
    for key,val in pairs(other) do
        if type(key) == 'number' then
            table.insert(target, val)
        else
            if target[key] == nil then
                target[key] = val
            elseif type(val) == 'table' then
                moretable.append_recursive(target[key], val)
            end
        end
    end
    return target
end

return moretable
