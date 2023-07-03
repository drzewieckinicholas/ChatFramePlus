local AceConfig = LibStub("AceConfig-3.0")
local AceConfigDialog = LibStub("AceConfigDialog-3.0")

--- @type string
local AddonName = select(1, ...)

--- @class Private
local Private = select(2, ...)

--- @class Options
local Options = {}

--- @class ChatFrameUtils
local ChatFrameUtils = Private.ChatFrameUtils

--- Creates an options table for a chat frame.
--- @param chatFrame table
--- @param index number
--- @return table
local function createOptionsTableForChatFrame(chatFrame, index)
	local BorderOptions = Private.BorderOptions
	local CopyOptions = Private.CopyOptions
	local FilterOptions = Private.FilterOptions
	local FontOptions = Private.FontOptions
	local TabOptions = Private.TabOptions

	return {
		border = BorderOptions:CreateOptionsTableForChatFrame(chatFrame, index),
		copy = CopyOptions:CreateOptionsTableForChatFrame(chatFrame, index),
		filter = FilterOptions:CreateOptionsTableForChatFrame(chatFrame, index),
		font = FontOptions:CreateOptionsTableForChatFrame(chatFrame, index),
		tab = TabOptions:CreateOptionsTableForChatFrame(chatFrame, index),
	}
end

--- Creates a base options table for the addon.
--- @return table
local function createOptionsTable()
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

	ChatFrameUtils:ForEachChatFrame(function(chatFrame, index)
		local chatFrameName = ChatFrameUtils:GetChatFrameName(chatFrame)
		local chatTabName = ChatFrameUtils:GetChatTabName(chatFrame)

		options.args.chatFrames.args[chatFrameName] = {
			order = index,
			type = "group",
			name = chatTabName,
			args = createOptionsTableForChatFrame(chatFrame, index),
		}
	end)

	return options
end

function Options:Initialize()
	AceConfig:RegisterOptionsTable(AddonName, createOptionsTable())
	AceConfigDialog:AddToBlizOptions(AddonName, AddonName)
end

Private.Options = Options
