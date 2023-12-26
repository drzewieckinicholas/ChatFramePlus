--- @class Private
local Private = select(2, ...)

--- @class FrameOptions
local FrameOptions = {}

--- @class FrameModule: AceModule
local FrameModule = Private.Addon:GetModule("Frame")

--- @class FrameConstants
local FrameConstants = Private.FrameConstants

--- @class DatabaseUtils
local DatabaseUtils = Private.DatabaseUtils

--- @class StringUtils
local StringUtils = Private.StringUtils

--- @type function
local newLine = StringUtils.GenerateNewLine

--- Returns the frame options table for the chat.
--- @return table
function FrameOptions:CreateOptionsTableForChat()
	local databaseFrame = DatabaseUtils.GetChatTable("frame")

	return {
		order = 2,
		type = "group",
		name = FrameModule.moduleName,
		desc = "Frame options.",
		args = {
			framePropertiesGroup = {
				order = 1,
				type = "group",
				name = "Frame Properties",
				inline = true,
				args = {
					frameShowDelay = {
						order = 1,
						type = "range",
						name = "Show Delay",
						desc = function()
							return table.concat({
								"Set the chat show delay.",
								"This is the amount of time it takes for the chat to start the fade in animation on mouseover.",
							}, newLine(2))
						end,
						min = FrameConstants.SHOW_DELAY_MIN,
						max = FrameConstants.SHOW_DELAY_MAX,
						step = FrameConstants.SHOW_DELAY_STEP,
						width = "full",
						get = function()
							return databaseFrame.showDelay
						end,
						set = function(_, value)
							databaseFrame.showDelay = value

							FrameModule:UpdateShowDelay(value)
						end,
					},
					frameHideDelay = {
						order = 2,
						type = "range",
						name = "Hide Delay",
						desc = function()
							return table.concat({
								"Set the chat hide delay.",
								"This is the amount of time it takes for the chat to start the fade out animation on mouseout.",
							}, newLine(2))
						end,
						min = FrameConstants.HIDE_DELAY_MIN,
						max = FrameConstants.HIDE_DELAY_MAX,
						step = FrameConstants.HIDE_DELAY_STEP,
						width = "full",
						get = function()
							return databaseFrame.hideDelay
						end,
						set = function(_, value)
							databaseFrame.hideDelay = value

							FrameModule:UpdateHideDelay(value)
						end,
					},
					frameFadeInTime = {
						order = 3,
						type = "range",
						name = "Fade In Time",
						desc = "Set the chat fade in time.",
						min = FrameConstants.FADE_IN_TIME_MIN,
						max = FrameConstants.FADE_IN_TIME_MAX,
						step = FrameConstants.FADE_IN_TIME_STEP,
						width = "full",
						get = function()
							return databaseFrame.fadeInTime
						end,
						set = function(_, value)
							databaseFrame.fadeInTime = value

							FrameModule:UpdateFadeInTime(value)
						end,
					},
					frameFadeOutTime = {
						order = 4,
						type = "range",
						name = "Fade Out Time",
						desc = "Set the chat fade out time.",
						min = FrameConstants.FADE_OUT_TIME_MIN,
						max = FrameConstants.FADE_OUT_TIME_MAX,
						step = FrameConstants.FADE_OUT_TIME_STEP,
						width = "full",
						get = function()
							return databaseFrame.fadeOutTime
						end,
						set = function(_, value)
							databaseFrame.fadeOutTime = value

							FrameModule:UpdateFadeOutTime(value)
						end,
					},
				},
			},
		},
	}
end

Private.FrameOptions = FrameOptions
