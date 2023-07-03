--- @type string
local AddonName = select(1, ...)

--- @class Private
local Private = select(2, ...)

--- @class CopyConstants
local CopyConstants = {}

--- @type string
CopyConstants.FRAME_TITLE = AddonName .. " Copy"

--- @type string
CopyConstants.FRAME_LAYOUT = "Fill"

--- @type number
CopyConstants.FRAME_WIDTH = 400

--- @type number
CopyConstants.FRAME_HEIGHT = 250

--- @type string
CopyConstants.FRAME_STRATA = "DIALOG"

Private.CopyConstants = CopyConstants
