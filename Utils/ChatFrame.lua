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

function ChatFrameUtils.getChatFrame(index)
	return _G["ChatFrame" .. index]
end

function ChatFrameUtils.getChatFrameId(chatFrame)
	return chatFrame and chatFrame:GetID()
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
