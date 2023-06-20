local _, Private = ...

local BorderConstants = Private:CreateTable({ "Constants", "Border" })

BorderConstants.MARGIN_MIN = 0
BorderConstants.MARGIN_MAX = 8
BorderConstants.MARGIN_STEP = 0.5

BorderConstants.SIZE_MIN = 8
BorderConstants.SIZE_MAX = 16
BorderConstants.SIZE_STEP = 1

BorderConstants.TEXTURES = {
	["Interface\\DialogFrame\\UI-DialogBox-Border"] = "Blizzard Dialog",
	["Interface\\Tooltips\\UI-Tooltip-Border"] = "Blizzard Tooltip",
}
