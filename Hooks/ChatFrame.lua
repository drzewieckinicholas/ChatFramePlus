local AceConfigRegistry = LibStub("AceConfigRegistry-3.0")

--- @type string
local AddonName = select(1, ...)

--- @class Private
local Private = select(2, ...)

--- @class ChatFrameHooks
local ChatFrameHooks = {}

--- @class CopyModule: AceModule
local CopyModule = Private.Addon:GetModule("Copy")

--- @class FontModule: AceModule
local FontModule = Private.Addon:GetModule("Font")

--- @class ChatFrameUtils
local ChatFrameUtils = Private.ChatFrameUtils

--- @class DatabaseUtils
local DatabaseUtils = Private.DatabaseUtils

--- Hooks into FCF_SetChatWindowFontSize to update the font size in the database and options.
--- @param self nil|table
--- @param chatFrame table?
--- @param fontSize number?
local function handleSetChatWindowFontSize(self, chatFrame, fontSize)
	if not chatFrame then
		chatFrame = FCF_GetCurrentChatFrame()
	end

	local chatFrameId = ChatFrameUtils:GetChatFrameId(chatFrame)

	if not fontSize then
		fontSize = self and self.value
	end

	local databaseFont = DatabaseUtils.GetChatFramesTable(chatFrameId, "font")

	databaseFont.size = fontSize

	FontModule:UpdateFont(chatFrame, nil, fontSize)

	AceConfigRegistry:NotifyChange(AddonName)
end

--- Hooks into FCF_Tab_OnClick to show the copy frame when the chat tab is left clicked while holding down the control key.
--- @param chatTab table
--- @param button string
local function handleTabOnClick(chatTab, button)
	if IsControlKeyDown() and button == "LeftButton" then
		local chatFrameId = ChatFrameUtils:GetChatFrameId(chatTab)
		local chatFrame = ChatFrameUtils:GetChatFrame(chatFrameId)
		local chatTabName = ChatFrameUtils:GetChatTabName(chatFrame)
		local databaseCopy = DatabaseUtils.GetChatFramesTable(chatFrameId, "copy")

		if databaseCopy.isEnabled then
			CopyModule:Show(chatFrame)
		else
			chatFrame:AddMessage(
				string.format("Copy is disabled for %s. Please enable it in the options.", chatTabName)
			)
		end
	end
end

function ChatFrameHooks:Initialize()
	hooksecurefunc("FCF_SetChatWindowFontSize", handleSetChatWindowFontSize)
	hooksecurefunc("FCF_Tab_OnClick", handleTabOnClick)
end

Private.ChatFrameHooks = ChatFrameHooks
