--- @class Private
local Private = select(2, ...)

--- @class ChatFrameUtils
local ChatFrameUtils = {}

--- Calls the callback function for each chat frame.
--- @param callback function
function ChatFrameUtils:ForEachChatFrame(callback)
	for index = 1, NUM_CHAT_WINDOWS do
		local chatFrame = self:GetChatFrame(index)

		callback(chatFrame, index)
	end
end

--- Calls the callback function for each chat frame message.
--- @param chatFrame table
--- @param callback function
function ChatFrameUtils:ForEachChatFrameMessage(chatFrame, callback)
	local numMessages = chatFrame:GetNumMessages()

	for index = 1, numMessages do
		local text, r, g, b = chatFrame:GetMessageInfo(index)

		callback(text, r, g, b)
	end
end

--- Returns a chat frame table e.g. ChatFrame1
--- @param index number
--- @return table
function ChatFrameUtils:GetChatFrame(index)
	return _G["ChatFrame" .. index]
end

--- Returns a chat frame background e.g. ChatFrame1Background
--- @param chatFrame table
--- @return table
function ChatFrameUtils:GetChatFrameBackground(chatFrame)
	return chatFrame and _G[self:GetChatFrameName(chatFrame) .. "Background"]
end

--- Returns a chat frame id e.g. 1
--- @param chatFrame table
--- @return number
function ChatFrameUtils:GetChatFrameId(chatFrame)
	return chatFrame and chatFrame:GetID()
end

--- Returns a chat frame name e.g. ChatFrame1
--- @param chatFrame table
--- @return string
function ChatFrameUtils:GetChatFrameName(chatFrame)
	return chatFrame and chatFrame:GetName()
end

--- Returns a chat frame texture e.g. ChatFrame1BottomTexture
--- @param chatFrame table
--- @param textureSuffix string
--- @return table?
function ChatFrameUtils:GetChatFrameTexture(chatFrame, textureSuffix)
	if not chatFrame then
		return
	end

	local chatFrameName = self:GetChatFrameName(chatFrame)
	local chatFrameTexture = _G[chatFrameName .. textureSuffix]

	return chatFrameTexture
end

--- Returns a chat tab table e.g. ChatFrame1Tab
--- @param chatFrame table
--- @return table
function ChatFrameUtils:GetChatTab(chatFrame)
	return chatFrame and _G[self:GetChatFrameName(chatFrame) .. "Tab"]
end

--- Returns a chat tab name e.g. Combat Log
--- @param chatFrame table
--- @return string?
function ChatFrameUtils:GetChatTabName(chatFrame)
	if not chatFrame then
		return
	end

	local chatTab = self:GetChatTab(chatFrame)

	return chatTab and chatTab:GetText()
end

Private.ChatFrameUtils = ChatFrameUtils
