--- @class Private
local Private = select(2, ...)

--- @class BorderModule: AceModule
local BorderModule = Private.Addon:NewModule("Border")

--- @class ChatFrameUtils
local ChatFrameUtils = Private.ChatFrameUtils

--- @class DatabaseUtils
local DatabaseUtils = Private.DatabaseUtils

--- @type table<number, table>
local borders = {}

--- Creates a border for a chat frame.
--- @param index number
--- @return table
local function createBorder(index)
	local border = CreateFrame("Frame", nil, UIParent, BackdropTemplateMixin and "BackdropTemplate")

	borders[index] = border

	return border
end

--- Configures the border for a chat frame.
--- @param chatFrame table
--- @param index number
--- @param border table
local function configureBorder(chatFrame, index, border)
	local databaseBorder = DatabaseUtils.GetChatFramesTable(index, "border")

	border:SetParent(chatFrame)

	BorderModule:UpdateBorderMargin(index, databaseBorder.margin)
	BorderModule:UpdateBorderColor(index, databaseBorder.color)
	BorderModule:UpdateBorderBackdrop(index, databaseBorder.size, databaseBorder.texture, databaseBorder.color)
	BorderModule:UpdateBorderIsEnabled(index, databaseBorder.isEnabled)
end

--- Initializes the border frame for a chat frame.
--- @param chatFrame table
--- @param index number
local function initializeBorder(chatFrame, index)
	local border = createBorder(index)

	configureBorder(chatFrame, index, border)
end

function BorderModule:OnEnable()
	ChatFrameUtils:ForEachChatFrame(function(chatFrame, index)
		initializeBorder(chatFrame, index)
	end)
end

--- Updates the border margin for a chat frame.
--- @param index number
--- @param margin number
function BorderModule:UpdateBorderMargin(index, margin)
	local border = borders[index]
	local chatFrame = ChatFrameUtils:GetChatFrame(index)
	local chatFrameBackground = ChatFrameUtils:GetChatFrameBackground(chatFrame)

	if border then
		border:SetPoint("TOPLEFT", chatFrameBackground, "TOPLEFT", -margin, margin)
		border:SetPoint("BOTTOMRIGHT", chatFrameBackground, "BOTTOMRIGHT", margin, -margin)
	end
end

--- Updates the border color for a chat frame.
--- @param index number
--- @param color table
function BorderModule:UpdateBorderColor(index, color)
	local border = borders[index]

	if border then
		border:SetBackdropBorderColor(color.r, color.g, color.b, color.a)
	end
end

--- Updates the border backdrop for a chat frame.
--- @param index number
--- @param size number
--- @param texture string
--- @param color table
function BorderModule:UpdateBorderBackdrop(index, size, texture, color)
	local border = borders[index]

	if border then
		border:SetBackdrop({ edgeFile = texture, edgeSize = size })
		border:SetBackdropBorderColor(color.r, color.g, color.b, color.a)
	end
end

--- Updates the border status for a chat frame.
--- @param index number
--- @param isEnabled boolean
function BorderModule:UpdateBorderIsEnabled(index, isEnabled)
	local border = borders[index]

	if border then
		border:SetShown(isEnabled)
	end
end
