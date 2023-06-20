local AddonName, Private = ...

local Options = Private:CreateTable({ "Options" })

local ChatFrameUtils = Private.Utils.ChatFrame

local function getChatFrameOptions(chatFrame, index)
	local BorderOptions = Options.Border
	local CopyOptions = Options.Copy
	local FilterOptions = Options.Filter
	local FontOptions = Options.Font

	return {
		border = BorderOptions.getBorderOptions(chatFrame, index),
		copy = CopyOptions.getCopyOptions(index),
		filter = FilterOptions.getFilterOptions(index),
		font = FontOptions.getFontOptions(chatFrame, index),
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
		if chatFrame then
			local chatFrameName = ChatFrameUtils.getChatFrameName(chatFrame)
			local chatTabName = ChatFrameUtils.getChatTabName(chatFrame)

			options.args.chatFrames.args[chatFrameName] = {
				order = index,
				type = "group",
				name = chatTabName,
				args = getChatFrameOptions(chatFrame, index),
			}
		end
	end)

	return options
end

function Options:RegisterOptionsTable()
	local AceConfig = LibStub("AceConfig-3.0")

	AceConfig:RegisterOptionsTable(AddonName, self:GetOptions())
end

function Options:AddOptionsTable()
	local AceConfigDialog = LibStub("AceConfigDialog-3.0")

	AceConfigDialog:AddToBlizOptions(AddonName, AddonName)
end

function Options:Init()
	self:RegisterOptionsTable()
	self:AddOptionsTable()
end
