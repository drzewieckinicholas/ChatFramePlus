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
						desc = "Toggle chat message copying on or off",
						width = "full",
						get = getCopyEnabled,
						set = setCopyEnabled,
					},
				},
			},
		},
	}
end
