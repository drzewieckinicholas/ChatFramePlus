local _, Private = ...

local ButtonOptions = Private:CreateTable({ "Options", "Button" })

local ButtonModule = Private.Addon:GetModule("Button")

local DatabaseUtils = Private.Utils.Database
local OptionsUtils = Private.Utils.Options

local createAccessors = OptionsUtils.createAccessors

function ButtonOptions.getOptionsForFrame(chatFrame, index)
	local buttonTable = function()
		return DatabaseUtils.getChatFramesTable(index, "button")
	end

	local handleUpdateBottomButton = function()
		ButtonModule:UpdateButtonVisibilityForFrame(chatFrame, "bottomButton")
	end

	local handleUpdateDownButton = function()
		ButtonModule:UpdateButtonVisibilityForFrame(chatFrame, "downButton")
	end

	local handleUpdateUpButton = function()
		ButtonModule:UpdateButtonVisibilityForFrame(chatFrame, "upButton")
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
