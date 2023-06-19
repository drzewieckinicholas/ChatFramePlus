local lower, match = string.lower, string.match

local _, Private = ...

local StringUtils = Private:CreateTable({ "Utils", "String" })

function StringUtils.sanitize(s)
	return lower((match(s, "^%s*(.*%S)%s*$") or ""):gsub("%p", ""))
end
