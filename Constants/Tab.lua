--- @class Private
local Private = select(2, ...)

--- @class TabConstants
local TabConstants = {}

--- @type table<string>
TabConstants.TEXTURES = {
	"TabLeft",
	"TabMiddle",
	"TabRight",
	"TabHighlightLeft",
	"TabHighlightMiddle",
	"TabHighlightRight",
	"TabSelectedLeft",
	"TabSelectedMiddle",
	"TabSelectedRight",
}

Private.TabConstants = TabConstants
