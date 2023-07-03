--- @class Private
local Private = select(2, ...)

--- @class BorderConstants
local BorderConstants = {}

--- @type number
BorderConstants.MARGIN_MIN = 0

--- @type number
BorderConstants.MARGIN_MAX = 8

--- @type number
BorderConstants.MARGIN_STEP = 0.5

--- @type number
BorderConstants.SIZE_MIN = 8

--- @type number
BorderConstants.SIZE_MAX = 16

--- @type number
BorderConstants.SIZE_STEP = 1

--- @type table<string, string>
BorderConstants.TEXTURES = {
	["Interface\\DialogFrame\\UI-DialogBox-Border"] = "Blizzard Dialog",
	["Interface\\Tooltips\\UI-Tooltip-Border"] = "Blizzard Tooltip",
}

Private.BorderConstants = BorderConstants
