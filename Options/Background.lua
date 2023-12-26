--- @class Private
local Private = select(2, ...)

--- @class BackgroundOptions
local BackgroundOptions = {}

--- @class BackgroundModule: AceModule
local BackgroundModule = Private.Addon:GetModule("Background")

--- @class DatabaseUtils
local DatabaseUtils = Private.DatabaseUtils

--- @class StringUtils
local StringUtils = Private.StringUtils

--- @type function
local newLine = StringUtils.GenerateNewLine

--- Returns the background options table for a chat frame.
--- @param chatFrame table
--- @param index number
--- @return table
function BackgroundOptions:CreateOptionsTableForChatFrame(chatFrame, index)
	local databaseBackground = DatabaseUtils.GetChatFramesTable(index, "background")

	return {
		order = 1,
		type = "group",
		name = BackgroundModule.moduleName,
		desc = "Background options.",
		args = {
			backgroundTogglesGroup = {
				order = 1,
				type = "group",
				name = "Background Toggles",
				inline = true,
				args = {
					backgroundIsVisible = {
						order = 1,
						type = "toggle",
						name = "Background Visible",
						desc = function()
							return table.concat({
								"Toggle the visibility of the chat background.",
								"By default, if you set the background color of a chat frame to transparent, the background will still show on mouseover.",
								"Disable this option to hide the background completely.",
							}, newLine(2))
						end,
						width = "full",
						get = function(_)
							return databaseBackground.isBackgroundVisible
						end,
						set = function(_, value)
							databaseBackground.isBackgroundVisible = value

							BackgroundModule:UpdateBackgroundVisibility(chatFrame)
						end,
					},
				},
			},
		},
	}
end

Private.BackgroundOptions = BackgroundOptions
