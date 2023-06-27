local _, Private = ...

local ChatFrameUtils = Private.Utils.ChatFrame

local function getBorderDefaultsForFrame()
	return {
		color = { r = 1, g = 1, b = 1, a = 1 },
		margin = 3,
		size = 12,
		texture = "Interface\\Tooltips\\UI-Tooltip-Border",
		isEnabled = false,
	}
end

local function getButtonDefaultsForFrame()
	return {
		isBottomButtonVisible = true,
		isDownButtonVisible = true,
		isUpButtonVisible = true,
	}
end

local function getCopyDefaultsForFrame()
	return {
		isEnabled = false,
	}
end

local function getFilterDefaultsForFrame()
	return {
		filterWords = {},
		filterWordsTrie = nil,
		isEnabled = false,
		isExactMatch = false,
		isShowFilteredMessages = false,
	}
end

local function getFontDefaultsForFrame()
	return {
		name = "Fonts\\ARIALN.TTF",
		size = 14,
		style = "",
	}
end

local function getTabDefaultsForFrame()
	return {
		isBackgroundVisible = true,
	}
end

function Private:GetDatabaseDefaults()
	local database = {
		profile = {
			chatFrames = {},
		},
	}

	ChatFrameUtils.forEachChatFrame(function(_, index)
		database.profile.chatFrames[index] = {
			border = getBorderDefaultsForFrame(),
			button = getButtonDefaultsForFrame(),
			copy = getCopyDefaultsForFrame(),
			filter = getFilterDefaultsForFrame(),
			font = getFontDefaultsForFrame(),
			tab = getTabDefaultsForFrame(),
		}
	end)

	return database
end
