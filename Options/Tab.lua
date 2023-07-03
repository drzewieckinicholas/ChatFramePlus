--- @class Private
local Private = select(2, ...)

--- @class TabOptions
local TabOptions = {}

--- @class TabModule: AceModule
local TabModule = Private.Addon:GetModule("Tab")

--- @class TabConstants
local TabConstants = Private.TabConstants

--- @class DatabaseUtils
local DatabaseUtils = Private.DatabaseUtils

--- Returns the tab options table for a chat frame.
--- @param chatFrame table
--- @param index number
--- @return table
function TabOptions:CreateOptionsTableForChatFrame(chatFrame, index)
	local databaseTab = DatabaseUtils.GetChatFramesTable(index, "tab")

	return {
		order = 4,
		type = "group",
		name = TabModule.moduleName,
		desc = "Tab options",
		args = {
			tabTogglesGroup = {
				order = 1,
				type = "group",
				name = "Tab Toggles",
				inline = true,
				args = {
					tabIsBackgroundVisible = {
						order = 1,
						type = "toggle",
						name = "Background Visible",
						desc = "Toggle the visibility of the chat tab background texture",
						width = "full",
						get = function(_)
							return databaseTab.isBackgroundVisible
						end,
						set = function(_, value)
							databaseTab.isBackgroundVisible = value

							TabModule:UpdateTab(chatFrame)
						end,
					},
				},
			},
		},
	}
end

Private.TabOptions = TabOptions
