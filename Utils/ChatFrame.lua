local insert = table.insert

local _G = _G

local NUM_CHAT_WINDOWS = NUM_CHAT_WINDOWS

local _, Private = ...

local ChatFrameUtils = Private:CreateTable({ "Utils", "ChatFrame" })

function ChatFrameUtils.forEachChatFrame(callback)
	for index = 1, NUM_CHAT_WINDOWS do
		local chatFrame = ChatFrameUtils.getChatFrame(index)

		if chatFrame then
			callback(chatFrame, index)
		end
	end
end

function ChatFrameUtils.forEachChatFrameMessage(chatFrame, callback)
	local numMessages = chatFrame:GetNumMessages()

	for index = 1, numMessages do
		local message = chatFrame:GetMessageInfo(index)

		if message then
			callback(message, index)
		end
	end
end

function ChatFrameUtils.getChatFrame(index)
	return _G["ChatFrame" .. index]
end

function ChatFrameUtils.getChatFrameBackground(chatFrame)
	return chatFrame and _G[ChatFrameUtils.getChatFrameName(chatFrame) .. "Background"]
end

function ChatFrameUtils.getChatFrameId(chatFrame)
	return chatFrame and chatFrame:GetID()
end

function ChatFrameUtils.getChatFrameMessages(chatFrame)
	local messages = {}

	ChatFrameUtils.forEachChatFrameMessage(chatFrame, function(message)
		insert(messages, message)
	end)

	return messages
end

function ChatFrameUtils.getChatFrameName(chatFrame)
	return chatFrame and chatFrame:GetName()
end

function ChatFrameUtils.getChatTab(chatFrame)
	return chatFrame and _G[ChatFrameUtils.getChatFrameName(chatFrame) .. "Tab"]
end

function ChatFrameUtils.getChatTabName(chatFrame)
	if not chatFrame then
		return
	end

	local chatTab = ChatFrameUtils.getChatTab(chatFrame)

	return chatTab and chatTab:GetText()
end
