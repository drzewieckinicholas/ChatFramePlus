--- @class Private
local Private = select(2, ...)

--- @class ChatFrameUtils
local ChatFrameUtils = Private.ChatFrameUtils

--- @class borderDefaultsForChatFrame
--- @field color table
--- @field margin number
--- @field size number
--- @field texture string
--- @field isEnabled boolean
local borderDefaultsForChatFrame = {
	color = { r = 1, g = 1, b = 1, a = 1 },
	margin = 2.5,
	size = 12,
	texture = "Interface\\Tooltips\\UI-Tooltip-Border",
	isEnabled = false,
}

--- @class copyDefaultsForChatFrame
--- @field isEnabled boolean
local copyDefaultsForChatFrame = {
	isEnabled = false,
}

--- @class filterDefaultsForChatFrame
--- @field words table
--- @field trie nil|table
--- @field isEnabled boolean
--- @field isExactMatch boolean
--- @field isShowFilteredMessages boolean
local filterDefaultsForChatFrame = {
	words = {},
	trie = nil,
	isEnabled = false,
	isExactMatch = false,
	isShowFilteredMessages = false,
}

--- @class fontDefaultsForChatFrame
--- @field name string
--- @field size number
--- @field style string
local fontDefaultsForChatFrame = {
	name = "Fonts\\ARIALN.TTF",
	size = 14,
	style = "",
}

--- @class tabDefaultsForChatFrame
--- @field isBackgroundVisible boolean
local tabDefaultsForChatFrame = {
	isBackgroundVisible = true,
}

--- Get the database defaults.
--- @return AceDBObject-3.0
function Private:GetDatabaseDefaults()
	--- @class AceDBObject-3.0
	local database = {
		profile = {
			chatFrames = {},
		},
	}

	ChatFrameUtils:ForEachChatFrame(function(_, index)
		database.profile.chatFrames[index] = {
			border = borderDefaultsForChatFrame,
			copy = copyDefaultsForChatFrame,
			filter = filterDefaultsForChatFrame,
			font = fontDefaultsForChatFrame,
			tab = tabDefaultsForChatFrame,
		}
	end)

	return database
end
