--- @class Private
local Private = select(2, ...)

--- @class FontConstants
local FontConstants = {}

--- @type number
FontConstants.SIZE_MIN = 12

--- @type number
FontConstants.SIZE_MAX = 24

--- @type number
FontConstants.SIZE_STEP = 2

--- @type table<string, string>
FontConstants.NAMES = {
	["Fonts\\ARIALN.TTF"] = "Arial Narrow",
	["Fonts\\FRIZQT__.TTF"] = "Friz Quadrata TT",
	["Fonts\\MORPHEUS.TTF"] = "Morpheus",
	["Fonts\\NIM_____.ttf"] = "Nimrod MT",
	["Fonts\\skurri.TTF"] = "Skurri",
	["Interface\\AddOns\\ChatFramePlus\\Assets\\Fonts\\custom-font-1.ttf"] = "Custom Font 1",
	["Interface\\AddOns\\ChatFramePlus\\Assets\\Fonts\\custom-font-2.ttf"] = "Custom Font 2",
	["Interface\\AddOns\\ChatFramePlus\\Assets\\Fonts\\custom-font-3.ttf"] = "Custom Font 3",
}

--- @type table<string, string>
FontConstants.STYLES = {
	[""] = "None",
	["OUTLINE"] = "Outline",
	["THICKOUTLINE"] = "Thick Outline",
}

Private.FontConstants = FontConstants
