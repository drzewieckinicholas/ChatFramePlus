--- @class Private
local Private = select(2, ...)

--- @class CopyOptions
local CopyOptions = {}

--- @class CopyModule: AceModule
local CopyModule = Private.Addon:GetModule("Copy")

--- @class DatabaseUtils
local DatabaseUtils = Private.DatabaseUtils

--- Returns the copy options table for a chat frame.
--- @param chatFrame table
--- @param index number
--- @return table
function CopyOptions:CreateOptionsTableForChatFrame(chatFrame, index)
	local databaseCopy = DatabaseUtils.GetChatFramesTable(index, "copy")

	return {
		order = 2,
		type = "group",
		name = CopyModule.moduleName,
		desc = "Copy options",
		args = {
			copyTogglesGroup = {
				order = 1,
				type = "group",
				name = "Copy Toggles",
				inline = true,
				args = {
					copyIsEnabled = {
						order = 1,
						type = "toggle",
						name = "Enabled",
						desc = function()
							local copy = {
								"Toggle chat message copying on or off",
								"This feature allows you to copy messages from a chat frame to the clipboard",
								"Hold down the control key and left click on a chat frame tab to show the copy frame",
							}

							return table.concat(copy, "\n\n")
						end,
						width = "full",
						get = function(_)
							return databaseCopy.isEnabled
						end,
						set = function(_, value)
							databaseCopy.isEnabled = value
						end,
					},
				},
			},
		},
	}
end

Private.CopyOptions = CopyOptions
