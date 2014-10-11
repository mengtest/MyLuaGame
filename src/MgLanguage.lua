
local stringsTable = nil
local stringFormat = string.format

local function getStringsTable()
    return require("MgStringsZh")
end

local function LocalizedString(text)
    if not stringsTable then
        stringsTable = getStringsTable()
    end 
    return stringsTable[text] or text
end

function T(text, ...)
    if not text then return end
    local text = LocalizedString(text, ...)
    local n = select("#", ...)
    return (n == 0) and text or stringFormat(text, ...) 
end

