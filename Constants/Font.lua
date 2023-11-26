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
	["Interface\\AddOns\\ChatFramePlus\\Assets\\Fonts\\OpenDyslexic3-Regular.ttf"] = "OpenDyslexic 3",
	["Interface\\AddOns\\ChatFramePlus\\Assets\\Fonts\\OpenDyslexicMono-Regular.otf"] = "OpenDyslexic Mono",
}

--- @type table<string, string>
FontConstants.STYLES = {
	[""] = "None",
	["OUTLINE"] = "Outline",
	["THICKOUTLINE"] = "Thick Outline",
}

Private.FontConstants = FontConstants
