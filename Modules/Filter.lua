local format = string.format

local _, Private = ...

local ChatFramePlus = Private:GetAddon()
local FilterModule = ChatFramePlus:NewModule("Filter")

local ChatFrameUtils = Private.Utils.ChatFrame
local DatabaseUtils = Private.Utils.Database
local FilterUtils = Private.Utils.Filter

function FilterModule:OnChatEventCallback(chatFrame, event, message, author)
	local chatFrameId = ChatFrameUtils.getChatFrameId(chatFrame)
	local filterTable = DatabaseUtils.getChatFramesTable(chatFrameId, "filter")

	if not filterTable.isEnabled then
		return false
	end

	if not FilterUtils.shouldFilterChatMessage(filterTable, message) then
		return false
	end

	if filterTable.isShowFilteredMessages then
		print(format("Filtered message from %s: %s", author, message))
	end

	return true
end

function FilterModule:HandleEventFilter(handler)
	local callback = function(...)
		return self:OnChatEventCallback(...)
	end

	for i = 1, #self.chatMessageEvents do
		handler(self.chatMessageEvents[i], callback)
	end
end

function FilterModule:AddMessageEventFilter()
	self:HandleEventFilter(ChatFrame_AddMessageEventFilter)
end

function FilterModule:RemoveMessageEventFilter()
	self:HandleEventFilter(ChatFrame_RemoveMessageEventFilter)
end

function FilterModule:OnInitialize()
	self.chatMessageEvents = FilterUtils.getChatMessageEvents()
end

function FilterModule:OnEnable()
	self:AddMessageEventFilter()
end

function FilterModule:OnDisable()
	self:RemoveMessageEventFilter()
end
