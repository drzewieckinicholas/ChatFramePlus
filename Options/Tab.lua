local _, Private = ...

local TabOptions = Private:CreateTable({ "Options", "Tab" })

local TabModule = Private.Addon:GetModule("Tab")

local DatabaseUtils = Private.Utils.Database
local OptionsUtils = Private.Utils.Options

local createAccessors = OptionsUtils.createAccessors

function TabOptions.getTabOptions(chatFrame, index)
	local tabTable = function()
		return DatabaseUtils.getChatFramesTable(index, "tab")
	end

	local handleUpdate = function()
		TabModule:UpdateTab(chatFrame)
	end

	local getBackgroundVisible, setBackgroundVisible =
		createAccessors(tabTable, { "isBackgroundVisible" }, nil, nil, handleUpdate)

	return {
		order = 5,
		type = "group",
		name = TabModule.moduleName,
		desc = "Options for the chat frame tab",
		args = {
			tabTogglesGroup = {
				order = 1,
				type = "group",
				name = "Tab Toggles",
				inline = true,
				args = {
					backgroundVisible = {
						order = 1,
						type = "toggle",
						name = "Background Visible",
						desc = "Toggle the visibility of the tab background",
						width = "full",
						get = getBackgroundVisible,
						set = setBackgroundVisible,
					},
				},
			},
		},
	}
end
