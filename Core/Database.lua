--- @class Private
local Private = select(2, ...)

--- @class Database
local Database = {}

--- @class ChatFrameUtils
local ChatFrameUtils = Private.ChatFrameUtils

--- @class backgroundDefaultsForChatFrame
--- @field isBackgroundVisible boolean
local backgroundDefaultsForChatFrame = {
	isBackgroundVisible = true,
}

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

--- @class buttonDefaultsForChat
--- @field isChannelButtonVisible boolean
--- @field isMenuButtonVisible boolean
local buttonDefaultsForChat = {
	isChannelButtonVisible = true,
	isMenuButtonVisible = true,
}

--- @class buttonDefaultsForChatFrame
--- @field isBottomButtonVisible boolean
--- @field isDownButtonVisible boolean
--- @field isUpButtonVisible boolean
local buttonDefaultsForChatFrame = {
	isBottomButtonVisible = true,
	isDownButtonVisible = true,
	isUpButtonVisible = true,
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

--- @class frameDefaultsForChat
--- @field fadeInTime number
--- @field fadeOutTime number
--- @field hideDelay number
--- @field showDelay number
local frameDefaultsForChat = {
	fadeInTime = 0.25,
	fadeOutTime = 0.25,
	hideDelay = 0,
	showDelay = 0,
}

--- @class tabDefaultsForChatFrame
--- @field isBackgroundVisible boolean
local tabDefaultsForChatFrame = {
	isBackgroundVisible = true,
}

--- Get the database defaults for a chat frame.
--- @return table
function Database.GetChatFrameDefaults()
	return {
		background = backgroundDefaultsForChatFrame,
		border = borderDefaultsForChatFrame,
		button = buttonDefaultsForChatFrame,
		copy = copyDefaultsForChatFrame,
		filter = filterDefaultsForChatFrame,
		font = fontDefaultsForChatFrame,
		tab = tabDefaultsForChatFrame,
	}
end

--- Get the database defaults.
--- @return AceDBObject-3.0
function Database:GetDatabaseDefaults()
	--- @class AceDBObject-3.0
	local database = {
		profile = {
			chat = {
				button = buttonDefaultsForChat,
				frame = frameDefaultsForChat,
			},
			chatFrames = {},
		},
	}

	ChatFrameUtils:ForEachChatFrame(function(_, index)
		database.profile.chatFrames[index] = self:GetChatFrameDefaults()
	end)

	return database
end

Private.Database = Database
