--- @class Private
local Private = select(2, ...)

--- @class FontConstants
local FontConstants = {}

--- @type number
FontConstants.SIZE_MIN = 12

--- @type number
FontConstants.SIZE_MAX = 18

--- @type number
FontConstants.SIZE_STEP = 2

--- @type table<string, string>
FontConstants.NAMES = {
	["Fonts\\ARIALN.TTF"] = "Arial Narrow",
	["Fonts\\FRIZQT__.TTF"] = "Friz Quadrata TT",
}

--- @type table<string, string>
FontConstants.STYLES = {
	[""] = "None",
	["OUTLINE"] = "Outline",
	["THICKOUTLINE"] = "Thick Outline",
}

Private.FontConstants = FontConstants
