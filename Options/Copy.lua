local concat = table.concat

local _, Private = ...

local CopyOptions = Private:CreateTable({ "Options", "Copy" })

local CopyModule = Private.Addon:GetModule("Copy")

local DatabaseUtils = Private.Utils.Database
local OptionsUtils = Private.Utils.Options

local createAccessors = OptionsUtils.createAccessors

function CopyOptions.getCopyOptions(index)
	local copyTable = function()
		return DatabaseUtils.getChatFramesTable(index, "copy")
	end

	local getCopyEnabled, setCopyEnabled = createAccessors(copyTable, { "isEnabled" })

	return {
		order = 2,
		type = "group",
		name = CopyModule.moduleName,
		desc = "Options for copying chat messages",
		args = {
			copyTogglesGroup = {
				order = 1,
				type = "group",
				name = "Copy Toggles",
				inline = true,
				args = {
					copyEnabled = {
						order = 1,
						type = "toggle",
						name = "Enabled",
						desc = function()
							local descriptions = {
								"Toggle chat message copying on or off",
								"Hold Ctrl and left click on a chat tab to open the copy frame",
							}

							return concat(descriptions, "\n\n")
						end,
						width = "full",
						get = getCopyEnabled,
						set = setCopyEnabled,
					},
				},
			},
		},
	}
end
