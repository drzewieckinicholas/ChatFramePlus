local _, Private = ...

local ChatFrameUtils = Private.Utils.ChatFrame

local borderDefaultsForFrame = {
	color = { r = 1, g = 1, b = 1, a = 1 },
	margin = 3,
	size = 12,
	texture = "Interface\\Tooltips\\UI-Tooltip-Border",
	isEnabled = false,
}

local buttonDefaultsForChat = {
	isChannelButtonVisible = true,
	isMenuButtonVisible = true,
}

local buttonDefaultsForFrame = {
	isBottomButtonVisible = true,
	isDownButtonVisible = true,
	isUpButtonVisible = true,
}

local copyDefaultsForFrame = {
	isEnabled = false,
}

local filterDefaultsForFrame = {
	filterWords = {},
	filterWordsTrie = nil,
	isEnabled = false,
	isExactMatch = false,
	isShowFilteredMessages = false,
}

local fontDefaultsForFrame = {
	name = "Fonts\\ARIALN.TTF",
	size = 14,
	style = "",
}

local tabDefaultsForFrame = {
	isBackgroundVisible = true,
}

function Private:GetDatabaseDefaults()
	local database = {
		profile = {
			chat = {
				button = buttonDefaultsForChat,
			},
			chatFrames = {},
		},
	}

	ChatFrameUtils.forEachChatFrame(function(_, index)
		database.profile.chatFrames[index] = {
			border = borderDefaultsForFrame,
			button = buttonDefaultsForFrame,
			copy = copyDefaultsForFrame,
			filter = filterDefaultsForFrame,
			font = fontDefaultsForFrame,
			tab = tabDefaultsForFrame,
		}
	end)

	return database
end
