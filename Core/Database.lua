local _, Private = ...

local ChatFrameUtils = Private.Utils.ChatFrame

local function createBorderDatabaseDefaults()
	return {
		color = { r = 1, g = 1, b = 1, a = 1 },
		margin = 3,
		size = 12,
		texture = "Interface\\Tooltips\\UI-Tooltip-Border",
		isEnabled = false,
	}
end

local function createCopyDatabaseDefaults()
	return {
		isEnabled = false,
	}
end

local function createFilterDatabaseDefaults()
	return {
		filterWords = {},
		filterWordsTrie = nil,
		isEnabled = false,
		isExactMatch = false,
		isShowFilteredMessages = false,
	}
end

local function createFontDatabaseDefaults()
	return {
		name = "Fonts\\ARIALN.TTF",
		size = 14,
		style = "",
	}
end

local function createTabDatabaseDefaults()
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

	local borderDatabaseDefaults = createBorderDatabaseDefaults()
	local copyDatabaseDefaults = createCopyDatabaseDefaults()
	local filterDatabaseDefaults = createFilterDatabaseDefaults()
	local fontDatabaseDefaults = createFontDatabaseDefaults()
	local tabDatabaseDefaults = createTabDatabaseDefaults()

	ChatFrameUtils.forEachChatFrame(function(_, index)
		database.profile.chatFrames[index] = {
			border = borderDatabaseDefaults,
			copy = copyDatabaseDefaults,
			filter = filterDatabaseDefaults,
			font = fontDatabaseDefaults,
			tab = tabDatabaseDefaults,
		}
	end)

	return database
end
