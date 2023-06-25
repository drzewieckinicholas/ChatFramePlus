local _, Private = ...

local FontModule = Private.Addon:NewModule("Font")

local ChatFrameUtils = Private.Utils.ChatFrame
local DatabaseUtils = Private.Utils.Database

function FontModule:UpdateFont(chatFrame)
	local chatFrameId = ChatFrameUtils.getChatFrameId(chatFrame)
	local fontTable = DatabaseUtils.getChatFramesTable(chatFrameId, "font")
	local name = fontTable.name
	local size = fontTable.size
	local style = fontTable.style

	chatFrame:SetFont(name, size, style)
end

function FontModule:OnEnable()
	ChatFrameUtils.forEachChatFrame(function(chatFrame)
		self:UpdateFont(chatFrame)
	end)
end
