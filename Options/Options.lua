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

--- Creates an options table for the chat.
--- @return table
local function createOptionsTableForChat()
	local ButtonOptions = Private.ButtonOptions
	local FrameOptions = Private.FrameOptions

	return {
		button = ButtonOptions:CreateOptionsTableForChat(),
		frame = FrameOptions:CreateOptionsTableForChat(),
	}
end

--- Creates an options table for a chat frame.
--- @param chatFrame table
--- @param index number
--- @return table
local function createOptionsTableForChatFrame(chatFrame, index)
	local BackgroundOptions = Private.BackgroundOptions
	local BorderOptions = Private.BorderOptions
	local ButtonOptions = Private.ButtonOptions
	local CopyOptions = Private.CopyOptions
	local FilterOptions = Private.FilterOptions
	local FontOptions = Private.FontOptions
	local TabOptions = Private.TabOptions

	return {
		background = BackgroundOptions:CreateOptionsTableForChatFrame(chatFrame, index),
		border = BorderOptions:CreateOptionsTableForChatFrame(chatFrame, index),
		button = ButtonOptions:CreateOptionsTableForChatFrame(chatFrame, index),
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
			chat = {
				order = 1,
				type = "group",
				name = "Chat",
				desc = "Options for the chat",
				args = createOptionsTableForChat(),
			},
			chatFrames = {
				order = 2,
				type = "group",
				name = "Chat Frames",
				desc = "Options for a chat frame",
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
