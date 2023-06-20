local _, Private = ...

local BorderOptions = Private:CreateTable({ "Options", "Border" })

local BorderModule = Private.Addon:GetModule("Border")

local BorderConstants = Private.Constants.Border

local DatabaseUtils = Private.Utils.Database
local OptionsUtils = Private.Utils.Options

local createAccessors = OptionsUtils.createAccessors

local function unpackColor(color)
	return color.r, color.g, color.b, color.a
end

local function packColor(r, g, b, a)
	return { r = r, g = g, b = b, a = a }
end

function BorderOptions.getBorderOptions(chatFrame, index)
	local borderTable = function(info)
		return DatabaseUtils.getChatFramesTable(index, "border")
	end

	local updateFunc = function()
		BorderModule:UpdateFrame(chatFrame)
	end

	local getBorderEnabled, setBorderEnabled = createAccessors(borderTable, { "isEnabled" }, nil, nil, updateFunc)

	local getBorderColor, setBorderColor = createAccessors(borderTable, { "color" }, unpackColor, packColor, updateFunc)

	local getBorderMargin, setBorderMargin = createAccessors(borderTable, { "margin" }, nil, nil, updateFunc)

	local getBorderSize, setBorderSize = createAccessors(borderTable, { "size" }, nil, nil, updateFunc)

	local getBorderTexture, setBorderTexture = createAccessors(borderTable, { "texture" }, nil, nil, updateFunc)

	return {
		order = 1,
		type = "group",
		name = BorderModule.moduleName,
		desc = "Options for the chat frame border",
		args = {
			borderTogglesGroup = {
				order = 1,
				type = "group",
				name = "Border Toggles",
				inline = true,
				args = {
					borderEnabled = {
						order = 1,
						type = "toggle",
						name = "Enabled",
						desc = "Toggle the border on or off",
						width = "full",
						get = getBorderEnabled,
						set = setBorderEnabled,
					},
				},
			},
			borderOptionsGroup = {
				order = 2,
				type = "group",
				name = "Border Options",
				inline = true,
				args = {
					borderColor = {
						order = 1,
						type = "color",
						name = "Color",
						desc = "Select the border color",
						hasAlpha = true,
						width = "full",
						get = getBorderColor,
						set = setBorderColor,
					},
					borderMargin = {
						order = 2,
						type = "range",
						name = "Margin",
						desc = "Select the border margin",
						min = BorderConstants.MARGIN_MIN,
						max = BorderConstants.MARGIN_MAX,
						step = BorderConstants.MARGIN_STEP,
						width = "full",
						get = getBorderMargin,
						set = setBorderMargin,
					},
					borderSize = {
						order = 3,
						type = "range",
						name = "Size",
						desc = "Select the border size",
						min = BorderConstants.SIZE_MIN,
						max = BorderConstants.SIZE_MAX,
						step = BorderConstants.SIZE_STEP,
						width = "full",
						get = getBorderSize,
						set = setBorderSize,
					},
					borderTexture = {
						order = 4,
						type = "select",
						name = "Texture",
						desc = "Select the border texture",
						values = BorderConstants.TEXTURES,
						width = "full",
						get = getBorderTexture,
						set = setBorderTexture,
					},
				},
			},
		},
	}
end
