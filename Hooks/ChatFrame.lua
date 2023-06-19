local AceEvent = LibStub("AceEvent-3.0")

local _, Private = ...

local ChatFrameHooks = Private:createTable({ "Hooks", "ChatFrame" })

local function handleSetChatWindowFontSize(self, chatFrame, fontSize)
	if not chatFrame then
		chatFrame = FCF_GetCurrentChatFrame()
	end

	if not fontSize then
		fontSize = self.value
	end

	AceEvent:SendMessage("ChatFramePlus_FontSizeChanged", chatFrame, fontSize)
end

function ChatFrameHooks:Init()
	hooksecurefunc("FCF_SetChatWindowFontSize", handleSetChatWindowFontSize)
end
