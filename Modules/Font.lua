local _, Private = ...

local ChatFramePlus = Private:GetAddon()
local FontModule = ChatFramePlus:NewModule("Font")

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
end
