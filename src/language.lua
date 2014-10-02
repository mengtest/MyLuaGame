
local strings_table = nil
local string_format = string.format

local function getStringsTable()
	return require("strings_zh")
end

local function LocalizedString(text)
	if not strings_table then
		strings_table = getStringsTable()
	end 
	return strings_table[text] or text
end

function T(text, ...)
	if not text then return end
	local text = LocalizedString(text, ...)
	local n = select("#", ...)
	return (n == 0) and text or string_format(text, ...) 
end

