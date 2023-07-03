--- @class Private
local Private = select(2, ...)

--- @class FilterModule: AceModule
local FilterModule = Private.Addon:NewModule("Filter")

--- @class ChatFrameUtils
local ChatFrameUtils = Private.ChatFrameUtils

--- @class DatabaseUtils
local DatabaseUtils = Private.DatabaseUtils

--- @class StringUtils
local StringUtils = Private.StringUtils

--- @class TrieUtils
local TrieUtils = Private.TrieUtils

--- @class FilterConstants
local FilterConstants = Private.FilterConstants

--- @type table<string>
local chatMessageEvents = FilterConstants.EVENTS

--- Checks if a chat message should be filtered.
--- @param message string
--- @param databaseFilter table
--- @return boolean?
local function shouldFilterChatMessage(message, databaseFilter)
	local trie = databaseFilter.trie
	local isExactMatch = databaseFilter.isExactMatch

	for word in string.gmatch(message, "%S+") do
		local sanitizedWord = StringUtils.Sanitize(word)

		if TrieUtils:ContainsWord(trie, sanitizedWord, isExactMatch) then
			return true
		end
	end
end

--- Handles a chat message event.
--- @param chatFrame table
--- @param event string
--- @param message string
--- @param author string
--- @return boolean
local function onChatEventCallback(chatFrame, event, message, author)
	local chatFrameId = ChatFrameUtils:GetChatFrameId(chatFrame)
	local databaseFilter = DatabaseUtils.GetChatFramesTable(chatFrameId, "filter")
	local isEnabled = databaseFilter.isEnabled
	local isShowFilteredMessages = databaseFilter.isShowFilteredMessages

	if isEnabled == false then
		return false
	end

	if not shouldFilterChatMessage(message, databaseFilter) then
		return false
	end

	if isShowFilteredMessages == true then
		chatFrame:AddMessage(string.format("%s: %s", author, message), 1, 0, 0)
	end

	return true
end

--- Adds or removes a message event filter.
--- @param handler function
local function handleEventFilter(handler)
	local callback = function(chatFrame, event, message, author)
		return onChatEventCallback(chatFrame, event, message, author)
	end

	for _, event in ipairs(chatMessageEvents) do
		handler(event, callback)
	end
end

local function addMessageEventFilter()
	handleEventFilter(ChatFrame_AddMessageEventFilter)
end

local function removeMessageEventFilter()
	handleEventFilter(ChatFrame_RemoveMessageEventFilter)
end

function FilterModule:OnEnable()
	addMessageEventFilter()
end

function FilterModule:OnDisable()
	removeMessageEventFilter()
end

Private.FilterModule = FilterModule
