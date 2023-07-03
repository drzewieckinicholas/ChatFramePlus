--- @class Private
local Private = select(2, ...)

--- @class FontOptions
local FontOptions = {}

--- @class FontModule: AceModule
local FontModule = Private.Addon:GetModule("Font")

--- @class FontConstants
local FontConstants = Private.FontConstants

--- @class DatabaseUtils
local DatabaseUtils = Private.DatabaseUtils

--- Returns the font options table for a chat frame.
--- @param chatFrame table
--- @param index number
--- @return table
function FontOptions:CreateOptionsTableForChatFrame(chatFrame, index)
	local databaseFont = DatabaseUtils.GetChatFramesTable(index, "font")

	return {
		order = 3,
		type = "group",
		name = FontModule.moduleName,
		desc = "Font options",
		args = {
			fontPropertiesGroup = {
				order = 1,
				type = "group",
				name = "Font Properties",
				inline = true,
				args = {
					fontSize = {
						order = 1,
						type = "range",
						name = "Font Size",
						desc = "Set the font size",
						min = FontConstants.SIZE_MIN,
						max = FontConstants.SIZE_MAX,
						step = FontConstants.SIZE_STEP,
						width = "full",
						get = function(_)
							return databaseFont.size
						end,
						set = function(_, value)
							databaseFont.size = value

							FontModule:UpdateFont(chatFrame, nil, value)
						end,
					},
					fontName = {
						order = 2,
						type = "select",
						name = "Font Name",
						desc = "Set the font name",
						values = FontConstants.NAMES,
						width = "full",
						get = function(_)
							return databaseFont.name
						end,
						set = function(_, value)
							databaseFont.name = value

							FontModule:UpdateFont(chatFrame, value)
						end,
					},
					fontStyle = {
						order = 3,
						type = "select",
						name = "Font Style",
						desc = "Set the font style",
						values = FontConstants.STYLES,
						width = "full",
						get = function(_)
							return databaseFont.style
						end,
						set = function(_, value)
							databaseFont.style = value

							FontModule:UpdateFont(chatFrame, nil, nil, value)
						end,
					},
				},
			},
		},
	}
end

Private.FontOptions = FontOptions
