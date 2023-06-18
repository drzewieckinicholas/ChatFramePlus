local _, Private = ...

local ChatFrameUtils = Private:createTable({ "Utils", "ChatFrame" })

function ChatFrameUtils.forEachChatFrame(callback)
	for index = 1, NUM_CHAT_WINDOWS do
		local chatFrame = _G["ChatFrame" .. index]

		if chatFrame then
			callback(chatFrame, index)
		end
	end
end

function ChatFrameUtils.getChatFrameName(chatFrame)
	return chatFrame and chatFrame:GetName()
end

function ChatFrameUtils.getChatTab(chatFrame)
	return chatFrame and _G[chatFrame:GetName() .. "Tab"]
end

function ChatFrameUtils.getChatTabName(chatFrame)
	if not chatFrame then
		return
	end

	local chatTab = ChatFrameUtils.getChatTab(chatFrame)

	return chatTab and chatTab:GetText()
end
