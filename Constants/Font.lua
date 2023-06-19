local _, Private = ...

local FontConstants = Private:createTable({ "Constants", "Font" })

FontConstants.SIZE_MIN = 12
FontConstants.SIZE_MAX = 18
FontConstants.SIZE_STEP = 2

FontConstants.NAMES = {
	["Fonts\\ARIALN.TTF"] = "Arial Narrow",
	["Fonts\\FRIZQT__.TTF"] = "Friz Quadrata TT",
}

FontConstants.STYLES = {
	[""] = "None",
	["OUTLINE"] = "Outline",
	["THICKOUTLINE"] = "Thick Outline",
}
