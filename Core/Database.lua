local _, Private = ...

local ChatFrameUtils = Private:getTable({ "Utils", "ChatFrame" })

local function createFontDatabaseDefaults()
	return {
		name = "Fonts\\ARIALN.TTF",
		size = 14,
		style = "NONE",
	}
end

function Private:GetDatabaseDefaults()
	local database = {
		profile = {
			chatFrames = {},
		},
	}

	local fontDatabaseDefaults = createFontDatabaseDefaults()

	ChatFrameUtils.forEachChatFrame(function(_, index)
		database.profile.chatFrames[index] = {
			font = fontDatabaseDefaults,
		}
	end)
end
