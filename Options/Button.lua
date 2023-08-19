--- @class Private
local Private = select(2, ...)

--- @class ButtonOptions
local ButtonOptions = {}

--- @class ButtonModule: AceModule
local ButtonModule = Private.Addon:GetModule("Button")

--- @class DatabaseUtils
local DatabaseUtils = Private.DatabaseUtils

function ButtonOptions:CreateOptionsTableForChat()
	local databaseButton = DatabaseUtils.GetChatTable("button")

	return {
		order = 1,
		type = "group",
		name = ButtonModule.moduleName,
		desc = "Button options",
		args = {
			buttonTogglesGroup = {
				order = 1,
				type = "group",
				name = "Button Toggles",
				inline = true,
				args = {
					channelButtonIsVisible = {
						order = 1,
						type = "toggle",
						name = "Channel Button Visible",
						desc = "Toggle the visibility of the channel button",
						width = "full",
						get = function()
							return databaseButton.isChannelButtonVisible
						end,
						set = function(_, value)
							databaseButton.isChannelButtonVisible = value

							ButtonModule:UpdateButtonVisibilityForChat()
						end,
					},
					menuButtonIsVisible = {
						order = 2,
						type = "toggle",
						name = "Menu Button Visible",
						desc = "Toggle the visibility of the menu button",
						width = "full",
						get = function()
							return databaseButton.isMenuButtonVisible
						end,
						set = function(_, value)
							databaseButton.isMenuButtonVisible = value

							ButtonModule:UpdateButtonVisibilityForChat()
						end,
					},
				},
			},
		},
	}
end

--- Returns the button options table for a chat frame.
--- @param chatFrame table
--- @param index number
--- @return table
function ButtonOptions:CreateOptionsTableForChatFrame(chatFrame, index)
	local databaseButton = DatabaseUtils.GetChatFramesTable(index, "button")

	return {
		order = 2,
		type = "group",
		name = ButtonModule.moduleName,
		desc = "Button options",
		args = {
			buttonTogglesGroup = {
				order = 1,
				type = "group",
				name = "Button Toggles",
				inline = true,
				args = {
					bottomButtonIsVisible = {
						order = 1,
						type = "toggle",
						name = "Bottom Button Visible",
						desc = "Toggle the visibility of the bottom button",
						width = "full",
						get = function()
							return databaseButton.isBottomButtonVisible
						end,
						set = function(_, value)
							databaseButton.isBottomButtonVisible = value

							ButtonModule:UpdateButtonVisibilityForChatFrame(chatFrame)
						end,
					},
					downButtonIsVisible = {
						order = 2,
						type = "toggle",
						name = "Down Button Visible",
						desc = "Toggle the visibility of the down button",
						width = "full",
						get = function()
							return databaseButton.isDownButtonVisible
						end,
						set = function(_, value)
							databaseButton.isDownButtonVisible = value

							ButtonModule:UpdateButtonVisibilityForChatFrame(chatFrame)
						end,
					},
					upButtonIsVisible = {
						order = 3,
						type = "toggle",
						name = "Up Button Visible",
						desc = "Toggle the visibility of the up button",
						width = "full",
						get = function()
							return databaseButton.isUpButtonVisible
						end,
						set = function(_, value)
							databaseButton.isUpButtonVisible = value

							ButtonModule:UpdateButtonVisibilityForChatFrame(chatFrame)
						end,
					},
				},
			},
		},
	}
end

Private.ButtonOptions = ButtonOptions
