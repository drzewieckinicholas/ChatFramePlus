local _, Private = ...

local ChatFrameUtils = Private.Utils.ChatFrame

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

function Private:GetDatabaseDefaults()
	local database = {
		profile = {
			chatFrames = {},
		},
	}

	local copyDatabaseDefaults = createCopyDatabaseDefaults()
	local filterDatabaseDefaults = createFilterDatabaseDefaults()
	local fontDatabaseDefaults = createFontDatabaseDefaults()

	ChatFrameUtils.forEachChatFrame(function(_, index)
		database.profile.chatFrames[index] = {
			copy = copyDatabaseDefaults,
			filter = filterDatabaseDefaults,
			font = fontDatabaseDefaults,
		}
	end)

	return database
end
