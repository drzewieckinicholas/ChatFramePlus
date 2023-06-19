local AddonName, Private = ...

local ChatFrameHooks = Private:createTable({ "Hooks", "ChatFrame" })

local ChatFramePlus = LibStub("AceAddon-3.0"):GetAddon(AddonName)
local FontModule = ChatFramePlus:GetModule("Font")

local ChatFrameUtils = Private.Utils.ChatFrame
local DatabaseUtils = Private.Utils.Database

local function handleSetChatWindowFontSize(self, chatFrame, fontSize)
	if not chatFrame then
		chatFrame = FCF_GetCurrentChatFrame()
	end

	if not fontSize then
		fontSize = self.value
	end

	local chatFrameId = ChatFrameUtils.getChatFrameId(chatFrame)
	local fontTable = DatabaseUtils.getChatFramesTable(chatFrameId, "font")

	fontTable.size = fontSize

	FontModule:UpdateFont(chatFrame)

	LibStub("AceConfigRegistry-3.0"):NotifyChange(AddonName)
end

function ChatFrameHooks:Init()
	hooksecurefunc("FCF_SetChatWindowFontSize", handleSetChatWindowFontSize)
end
