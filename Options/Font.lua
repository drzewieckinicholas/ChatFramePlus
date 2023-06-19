local _, Private = ...

local FontOptions = Private:CreateTable({ "Options", "Font" })

local FontModule = Private:GetModule("Font")

local FontConstants = Private.Constants.Font

local DatabaseUtils = Private.Utils.Database
local OptionsUtils = Private.Utils.Options
local createAccessors = OptionsUtils.createAccessors

function FontOptions.getFontOptions(chatFrame, index)
	local fontTable = function(_)
		return DatabaseUtils.getChatFramesTable(index, "font")
	end

	local updateFunc = function(_)
		FontModule:UpdateFont(chatFrame)
	end

	local getFontSize, setFontSize = createAccessors(fontTable, { "size" }, nil, nil, updateFunc)
	local getFontName, setFontName = createAccessors(fontTable, { "name" }, nil, nil, updateFunc)
	local getFontStyle, setFontStyle = createAccessors(fontTable, { "style" }, nil, nil, updateFunc)

	return {
		order = 1,
		type = "group",
		name = "Font",
		desc = "Options for the chat frame font",
		args = {
			fontOptionsGroup = {
				order = 1,
				type = "group",
				name = "Font Options",
				inline = true,
				args = {
					fontSize = {
						order = 1,
						type = "range",
						name = "Font Size",
						desc = "Select the font size",
						min = FontConstants.SIZE_MIN,
						max = FontConstants.SIZE_MAX,
						step = FontConstants.SIZE_STEP,
						width = "full",
						get = getFontSize,
						set = setFontSize,
					},
					fontName = {
						order = 2,
						type = "select",
						name = "Font Name",
						desc = "Select the font name",
						values = FontConstants.NAMES,
						width = "full",
						get = getFontName,
						set = setFontName,
					},
					fontStyle = {
						order = 3,
						type = "select",
						name = "Font Style",
						desc = "Select the font style",
						values = FontConstants.STYLES,
						width = "full",
						get = getFontStyle,
						set = setFontStyle,
					},
				},
			},
		},
	}
end
