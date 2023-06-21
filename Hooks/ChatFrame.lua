local AddonName, Private = ...

local ChatFrameHooks = Private:CreateTable({ "Hooks", "ChatFrame" })

local CopyModule = Private.Addon:GetModule("Copy")
local FontModule = Private.Addon:GetModule("Font")

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

local function handleChatTabClick(chatTab, button)
	if IsControlKeyDown() and button == "LeftButton" then
		local chatFrameId = ChatFrameUtils.getChatFrameId(chatTab)
		local chatFrame = ChatFrameUtils.getChatFrame(chatFrameId)
		local chatTabName = ChatFrameUtils.getChatTabName(chatFrame)
		local copyTable = DatabaseUtils.getChatFramesTable(chatFrameId, "copy")

		if copyTable.isEnabled then
			CopyModule:ShowFrame(chatFrame)
		else
			print(format("Copy is disabled for %s. You can enable it in the options.", chatTabName))
		end
	end
end

function ChatFrameHooks:Init()
	hooksecurefunc("FCF_SetChatWindowFontSize", handleSetChatWindowFontSize)
	hooksecurefunc("FCF_Tab_OnClick", handleChatTabClick)
end
