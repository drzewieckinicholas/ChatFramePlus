local _, Private = ...

local FontUtils = Private:CreateTable({ "Utils", "Font" })

function FontUtils.getFontName(fontTable)
	return fontTable and fontTable.name
end

function FontUtils.getFontSize(fontTable)
	return fontTable and fontTable.size
end

function FontUtils.getFontStyle(fontTable)
	return fontTable and fontTable.style
end
