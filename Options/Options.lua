local AddonName, Private = ...

local Options = Private:CreateTable({ "Options" })

local ChatFrameUtils = Private.Utils.ChatFrame

local function getChatFrameOptions(chatFrame, index)
	local BorderOptions = Options.Border
	local CopyOptions = Options.Copy
	local FilterOptions = Options.Filter
	local FontOptions = Options.Font
	local TabOptions = Options.Tab

	return {
		border = BorderOptions.getBorderOptions(chatFrame, index),
		copy = CopyOptions.getCopyOptions(index),
		filter = FilterOptions.getFilterOptions(index),
		font = FontOptions.getFontOptions(chatFrame, index),
		tab = TabOptions.getTabOptions(chatFrame, index),
	}
end

function Options:GetOptions()
	local options = {
		type = "group",
		name = AddonName,
		args = {
			chatFrames = {
				order = 1,
				type = "group",
				name = "Chat Frames",
				desc = "Options for each chat frame",
				args = {},
			},
		},
	}

	ChatFrameUtils.forEachChatFrame(function(chatFrame, index)
		local chatFrameName = ChatFrameUtils.getChatFrameName(chatFrame)
		local chatTabName = ChatFrameUtils.getChatTabName(chatFrame)

		options.args.chatFrames.args[chatFrameName] = {
			order = index,
			type = "group",
			name = chatTabName,
			args = getChatFrameOptions(chatFrame, index),
		}
	end)

	return options
end

function Options:RegisterOptionsTable()
	LibStub("AceConfig-3.0"):RegisterOptionsTable(AddonName, self:GetOptions())
end

function Options:AddOptionsTable()
	LibStub("AceConfigDialog-3.0"):AddToBlizOptions(AddonName, AddonName)
end

function Options:Init()
	self:RegisterOptionsTable()
	self:AddOptionsTable()
end
