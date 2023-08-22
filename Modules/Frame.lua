--- @class Private
local Private = select(2, ...)

--- @class FrameModule: AceModule
local FrameModule = Private.Addon:NewModule("Frame")

--- @class ChatFrameUtils
local ChatFrameUtils = Private.ChatFrameUtils

--- @class DatabaseUtils
local DatabaseUtils = Private.DatabaseUtils

--- Updates the fade in time for the chat.
--- @param value? number
function FrameModule:UpdateFadeInTime(value)
	local databaseFrame = DatabaseUtils.GetChatTable("frame")

	if not value then
		value = databaseFrame.fadeInTime
	end

	CHAT_FRAME_FADE_TIME = value
end

--- Updates the fade out time for the chat.
--- @param value? number
function FrameModule:UpdateFadeOutTime(value)
	local databaseFrame = DatabaseUtils.GetChatTable("frame")

	if not value then
		value = databaseFrame.fadeOutTime
	end

	CHAT_FRAME_FADE_OUT_TIME = value
end

--- Updates the hide delay for the chat.
--- @param value? number
function FrameModule:UpdateHideDelay(value)
	local databaseFrame = DatabaseUtils.GetChatTable("frame")

	if not value then
		value = databaseFrame.hideDelay
	end

	CHAT_TAB_HIDE_DELAY = value
end

--- Updates the show delay for the chat.
--- @param value? number
function FrameModule:UpdateShowDelay(value)
	local databaseFrame = DatabaseUtils.GetChatTable("frame")

	if not value then
		value = databaseFrame.showDelay
	end

	CHAT_TAB_SHOW_DELAY = value
end

function FrameModule:OnEnable()
	self:UpdateFadeInTime()
	self:UpdateFadeOutTime()
	self:UpdateHideDelay()
	self:UpdateShowDelay()
end
