local _, Private = ...

local ButtonOptions = Private:CreateTable({ "Options", "Button" })

local ButtonModule = Private.Addon:GetModule("Button")

local DatabaseUtils = Private.Utils.Database
local OptionsUtils = Private.Utils.Options

local createAccessors = OptionsUtils.createAccessors

function ButtonOptions.getOptionsForChat()
	local buttonTable = function()
		return DatabaseUtils.getChatTable("button")
	end

	local handleUpdateChannelButton = function()
		ButtonModule:UpdateButtonVisibility(nil, "channelButton")
	end

	local handleUpdateMenuButton = function()
		ButtonModule:UpdateButtonVisibility(nil, "menuButton")
	end

	local getChannelButtonVisible, setChannelButtonVisible =
		createAccessors(buttonTable, { "isChannelButtonVisible" }, nil, nil, handleUpdateChannelButton)

	local getMenuButtonVisible, setMenuButtonVisible =
		createAccessors(buttonTable, { "isMenuButtonVisible" }, nil, nil, handleUpdateMenuButton)

	return {
		order = 1,
		type = "group",
		name = ButtonModule.moduleName,
		desc = "Options for buttons that appear on all chat frames",
		args = {
			buttonTogglesGroup = {
				order = 1,
				type = "group",
				name = "Button Toggles",
				inline = true,
				args = {
					channelButtonVisible = {
						order = 1,
						type = "toggle",
						name = "Channel Button Visible",
						desc = "Toggle the visibility of the channel button",
						width = "full",
						get = getChannelButtonVisible,
						set = setChannelButtonVisible,
					},
					menuButtonVisible = {
						order = 2,
						type = "toggle",
						name = "Menu Button Visible",
						desc = "Toggle the visibility of the menu button",
						width = "full",
						get = getMenuButtonVisible,
						set = setMenuButtonVisible,
					},
				},
			},
		},
	}
end

function ButtonOptions.getOptionsForFrame(chatFrame, index)
	local buttonTable = function()
		return DatabaseUtils.getChatFramesTable(index, "button")
	end

	local handleUpdateBottomButton = function()
		ButtonModule:UpdateButtonVisibility(chatFrame, "bottomButton")
	end

	local handleUpdateDownButton = function()
		ButtonModule:UpdateButtonVisibility(chatFrame, "downButton")
	end

	local handleUpdateUpButton = function()
		ButtonModule:UpdateButtonVisibility(chatFrame, "upButton")
	end

	local getBottomButtonVisible, setBottomButtonVisible =
		createAccessors(buttonTable, { "isBottomButtonVisible" }, nil, nil, handleUpdateBottomButton)

	local getDownButtonVisible, setDownButtonVisible =
		createAccessors(buttonTable, { "isDownButtonVisible" }, nil, nil, handleUpdateDownButton)

	local getUpButtonVisible, setUpButtonVisible =
		createAccessors(buttonTable, { "isUpButtonVisible" }, nil, nil, handleUpdateUpButton)

	return {
		order = 2,
		type = "group",
		name = ButtonModule.moduleName,
		desc = "Options for buttons specific to this chat frame",
		args = {
			buttonTogglesGroup = {
				order = 1,
				type = "group",
				name = "Button Toggles",
				inline = true,
				args = {
					bottomButtonVisible = {
						order = 1,
						type = "toggle",
						name = "Bottom Button Visible",
						desc = "Toggle the visibility of the bottom button",
						width = "full",
						get = getBottomButtonVisible,
						set = setBottomButtonVisible,
					},
					downButtonVisible = {
						order = 2,
						type = "toggle",
						name = "Down Button Visible",
						desc = "Toggle the visibility of the down button",
						width = "full",
						get = getDownButtonVisible,
						set = setDownButtonVisible,
					},
					upButtonVisible = {
						order = 3,
						type = "toggle",
						name = "Up Button Visible",
						desc = "Toggle the visibility of the up button",
						width = "full",
						get = getUpButtonVisible,
						set = setUpButtonVisible,
					},
				},
			},
		},
	}
end
