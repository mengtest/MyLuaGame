
local assert, error, ipairs, pairs, select, type, tonumber, unpack = assert, error, ipairs, pairs, select, type, tonumber, unpack
local format, gsub, strfind, strsub = string.format, string.gsub, string.find, string.sub
local concat, tinsert = table.concat, table.insert
local ceil = math.ceil
local function parseargs(s)
    local arg = {}
    gsub(s, "([%-%w]+)=([\"'])(.-)%2", function(w, _, a)
            arg[w] = a
        end)
    return arg
end


local function collect(s)
    local stack = {}
    local top = {}
    local ni, c, tag, xarg, empty
    local i, j = 1, 1

    tinsert(stack, top)

    while true do
        ni, j, c, tag, xarg, empty = strfind(s, "<(%/?)([%w:]+)(.-)(%/?)>", i)

        if not ni then break end -- finish

        local text = strsub(s, i, ni - 1)

        if not strfind(text, "^%s*$") then -- for <?xml version='1.0'?>
            tinsert(top, text)
        end


        if empty == "/" then -- empty element tag
            tinsert(top, {tag = tag, xarg = parseargs(xarg), empty = 1})
        elseif c == "" then -- start tag ??
            top = {tag = tag, xarg= parseargs(xarg)}
            tinsert(stack, top)
        else -- end tag  value content
            local toclose = table.remove(stack) -- remove top
            top = stack[#stack]
            if #stack < 1 then
                error("nothing to close with "..tag)
            end
            if toclose.tag ~= tag then
                error("trying to close "..toclose.tag.." with "..tag)
            end
            tinsert(top, toclose)
        end
        i = j + 1
    end

    local text = strsub(s, i)

    if not strfind(text, "^%s*$") then
        tinsert(stack[#stack], text)
    end
    if #stack > 1 then
        error("unclosed "..stack[#stack].tag)
    end

    return stack[1][2]

end

return collect
