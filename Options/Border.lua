--- @class Private
local Private = select(2, ...)

--- @class BorderOptions
local BorderOptions = {}

--- @class BorderModule: AceModule
local BorderModule = Private.Addon:GetModule("Border")

--- @class BorderConstants
local BorderConstants = Private.BorderConstants

--- @class DatabaseUtils
local DatabaseUtils = Private.DatabaseUtils

--- Returns the border options table for a chat frame.
--- @param chatFrame table
--- @param index number
--- @return table
function BorderOptions:CreateOptionsTableForChatFrame(chatFrame, index)
	local databaseBorder = DatabaseUtils.GetChatFramesTable(index, "border")

	return {
		order = 1,
		type = "group",
		name = BorderModule.moduleName,
		desc = "Border options.",
		args = {
			borderTogglesGroup = {
				order = 1,
				type = "group",
				name = "Border Toggles",
				inline = true,
				args = {
					borderIsEnabled = {
						order = 1,
						type = "toggle",
						name = "Enabled",
						desc = "Toggle the border on or off.",
						width = "full",
						get = function(_)
							return databaseBorder.isEnabled
						end,
						set = function(_, value)
							databaseBorder.isEnabled = value

							BorderModule:UpdateBorderIsEnabled(index, value)
						end,
					},
				},
			},
			borderPropertiesGroup = {
				order = 2,
				type = "group",
				name = "Border Properties",
				inline = true,
				args = {
					borderColor = {
						order = 1,
						type = "color",
						name = "Color",
						desc = "Set the border color.",
						hasAlpha = true,
						width = "full",
						get = function(_)
							local color = databaseBorder.color

							return color.r, color.g, color.b, color.a
						end,
						set = function(_, r, g, b, a)
							local color = databaseBorder.color

							color.r = r
							color.g = g
							color.b = b
							color.a = a

							BorderModule:UpdateBorderColor(index, color)
						end,
					},
					borderMargin = {
						order = 2,
						type = "range",
						name = "Margin",
						desc = "Set the border margin.",
						min = BorderConstants.MARGIN_MIN,
						max = BorderConstants.MARGIN_MAX,
						step = BorderConstants.MARGIN_STEP,
						width = "full",
						get = function(_)
							return databaseBorder.margin
						end,
						set = function(_, value)
							databaseBorder.margin = value

							BorderModule:UpdateBorderMargin(index, value)
						end,
					},
					borderSize = {
						order = 3,
						type = "range",
						name = "Size",
						desc = "Set the border size.",
						min = BorderConstants.SIZE_MIN,
						max = BorderConstants.SIZE_MAX,
						step = BorderConstants.SIZE_STEP,
						width = "full",
						get = function(_)
							return databaseBorder.size
						end,
						set = function(_, value)
							databaseBorder.size = value

							BorderModule:UpdateBorderBackdrop(
								index,
								value,
								databaseBorder.texture,
								databaseBorder.color
							)
						end,
					},
					borderTexture = {
						order = 4,
						type = "select",
						name = "Texture",
						desc = "Set the border texture.",
						values = BorderConstants.TEXTURES,
						width = "full",
						get = function(_)
							return databaseBorder.texture
						end,
						set = function(_, value)
							databaseBorder.texture = value

							BorderModule:UpdateBorderBackdrop(index, databaseBorder.size, value, databaseBorder.color)
						end,
					},
				},
			},
		},
	}
end

Private.BorderOptions = BorderOptions
