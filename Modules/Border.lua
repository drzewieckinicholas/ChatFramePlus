local _, Private = ...

local BorderModule = Private.Addon:NewModule("Border")

local ChatFrameUtils = Private.Utils.ChatFrame
local DatabaseUtils = Private.Utils.Database

function BorderModule:GetFrame(chatFrameId)
	return self.borderFrames[chatFrameId]
end

function BorderModule:CreateFrame(chatFrameId)
	local borderFrame = self.borderPool:Acquire()

	self.borderFrames[chatFrameId] = borderFrame

	return borderFrame
end

function BorderModule:SetupFrame(borderFrame, chatFrame, borderTable)
	local chatFrameBackground = ChatFrameUtils.getChatFrameBackground(chatFrame)
	local color = borderTable.color
	local margin = borderTable.margin
	local size = borderTable.size
	local texture = borderTable.texture

	borderFrame:SetParent(chatFrame)
	borderFrame:SetPoint("TOPLEFT", chatFrameBackground, "TOPLEFT", -margin, margin)
	borderFrame:SetPoint("BOTTOMRIGHT", chatFrameBackground, "BOTTOMRIGHT", margin, -margin)
	borderFrame:SetBackdrop({
		edgeFile = texture,
		edgeSize = size,
	})
	borderFrame:SetBackdropBorderColor(color.r, color.g, color.b, color.a)
end

function BorderModule:ShowFrame(borderFrame)
	if not borderFrame:IsShown() then
		borderFrame:Show()
	end
end

function BorderModule:HideFrame(chatFrameId)
	local borderFrame = self:GetFrame(chatFrameId)

	if borderFrame then
		borderFrame:Hide()

		self.borderPool:Release(borderFrame)
		self.borderFrames[chatFrameId] = nil
	end
end

function BorderModule:UpdateFrame(chatFrame)
	local chatFrameId = ChatFrameUtils.getChatFrameId(chatFrame)
	local borderTable = DatabaseUtils.getChatFramesTable(chatFrameId, "border")

	if not borderTable.isEnabled then
		self:HideFrame(chatFrameId)

		return
	end

	local borderFrame = self:GetFrame(chatFrameId) or self:CreateFrame(chatFrameId)

	self:SetupFrame(borderFrame, chatFrame, borderTable)
	self:ShowFrame(borderFrame)
end

function BorderModule:OnInitialize()
	self.borderFrames = {}
	self.borderPool = CreateFramePool("Frame", UIParent, BackdropTemplateMixin and "BackdropTemplate")
end

function BorderModule:OnEnable()
	ChatFrameUtils.forEachChatFrame(function(chatFrame)
		self:UpdateFrame(chatFrame)
	end)
end
