local _, Private = ...

local FilterConstants = Private:CreateTable({ "Constants", "Filter" })

FilterConstants.EVENTS = {
	"CHAT_MSG_CHANNEL",
	"CHAT_MSG_SAY",
	"CHAT_MSG_WHISPER",
	"CHAT_MSG_YELL",
}
