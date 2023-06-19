local _, Private = ...

local FontOptions = Private:createTable({ "Options", "Font" })

local FontConstants = Private.Constants.Font

function FontOptions.getFontOptions(chatFrame, index)
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
						get = function() end,
						set = function() end,
					},
					fontName = {
						order = 2,
						type = "select",
						name = "Font Name",
						desc = "Select the font name",
						values = FontConstants.NAMES,
						width = "full",
						get = function() end,
						set = function() end,
					},
					fontStyle = {
						order = 3,
						type = "select",
						name = "Font Style",
						desc = "Select the font style",
						values = FontConstants.STYLES,
						width = "full",
						get = function() end,
						set = function() end,
					},
				},
			},
		},
	}
end
