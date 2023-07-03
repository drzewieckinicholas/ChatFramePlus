--- @class Private
local Private = select(2, ...)

--- @class StringUtils
local StringUtils = {}

--- Returns n newlines.
--- @param iterations number
--- @return string
function StringUtils.GenerateNewLine(iterations)
	local newLine = ""

	for _ = 1, iterations do
		newLine = newLine .. "\n"
	end

	return newLine
end

--- Returns a string with all letters lowercased, all leading and trailing whitespace removed, and all punctuation removed.
--- e.g. " Hello, World " -> "hello world"
--- @param string string
--- @return string
function StringUtils.Sanitize(string)
	return string.lower((string.match(string, "^%s*(.*%S)%s*$") or ""):gsub("%p", ""))
end

--- Returns a table of strings split by the delimiter.
--- e.g. "a,b,c" -> { "a", "b", "c" }
--- @param string string
--- @param delimiter string?
--- @return table
function StringUtils.Split(string, delimiter)
	local result = {}

	for match in (string .. delimiter):gmatch("(.-)" .. delimiter) do
		table.insert(result, match)
	end

	return result
end

Private.StringUtils = StringUtils
