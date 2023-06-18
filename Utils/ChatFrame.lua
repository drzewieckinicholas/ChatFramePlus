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
