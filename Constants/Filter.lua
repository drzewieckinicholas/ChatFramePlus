--- @class Private
local Private = select(2, ...)

--- @class FilterConstants
local FilterConstants = {}

--- @type table<string>
FilterConstants.EVENTS = {
	"CHAT_MSG_CHANNEL",
	"CHAT_MSG_SAY",
	"CHAT_MSG_WHISPER",
	"CHAT_MSG_YELL",
}

Private.FilterConstants = FilterConstants
