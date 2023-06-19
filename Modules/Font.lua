local AddonName, Private = ...

local FontModule = LibStub("AceAddon-3.0"):GetAddon(AddonName):NewModule("Font", "AceEvent-3.0")

local ChatFrameUtils = Private.Utils.ChatFrame
local DatabaseUtils = Private.Utils.Database
local FontUtils = Private.Utils.Font

function FontModule:UpdateFont(chatFrame)
	local chatFrameId = ChatFrameUtils.getChatFrameId(chatFrame)
	local fontTable = DatabaseUtils.getChatFramesTable(chatFrameId, "font")
	local fontName = FontUtils.getFontName(fontTable)
	local fontSize = FontUtils.getFontSize(fontTable)
	local fontStyle = FontUtils.getFontStyle(fontTable)

	chatFrame:SetFont(fontName, fontSize, fontStyle)
end

function FontModule:OnEnable()
	ChatFrameUtils.forEachChatFrame(function(chatFrame)
		self:UpdateFont(chatFrame)
	end)

	self:RegisterMessage("ChatFramePlus_FontSizeChanged", "HandleFontSizeChanged")
end

function FontModule:OnDisable()
	self:UnregisterMessage("ChatFramePlus_FontSizeChanged")
end

function FontModule:HandleFontSizeChanged(_, chatFrame, fontSize)
	local chatFrameId = ChatFrameUtils.getChatFrameId(chatFrame)
	local fontTable = DatabaseUtils.getChatFramesTable(chatFrameId, "font")

	fontTable.size = fontSize

	self:UpdateFont(chatFrame)

	LibStub("AceConfigRegistry-3.0"):NotifyChange(AddonName)
end
