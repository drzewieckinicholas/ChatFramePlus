--- @class Private
local Private = select(2, ...)

--- @class FontModule: AceModule
local FontModule = Private.Addon:NewModule("Font")

--- @class ChatFrameUtils
local ChatFrameUtils = Private.ChatFrameUtils

--- @class DatabaseUtils
local DatabaseUtils = Private.DatabaseUtils

--- Updates the font properties for a chat frame.
--- @param chatFrame table
--- @param name string?
--- @param size number?
--- @param style string?
function FontModule:UpdateFont(chatFrame, name, size, style)
	assert(type(chatFrame) == "table", "bad argument #1 expected table got " .. type(chatFrame))

	local chatFrameId = ChatFrameUtils:GetChatFrameId(chatFrame)
	local databaseFont = DatabaseUtils.GetChatFramesTable(chatFrameId, "font")

	if not name then
		name = databaseFont.name
	end

	assert(type(name) == "string", "bad argument #2 expected string got " .. type(name))

	if not size then
		size = databaseFont.size
	end

	assert(type(size) == "number", "bad argument #3 expected number got " .. type(size))

	if not style then
		style = databaseFont.style
	end

	assert(type(style) == "string", "bad argument #4 expected string got " .. type(style))

	chatFrame:SetFont(name, size, style)
end

function FontModule:OnEnable()
	ChatFrameUtils:ForEachChatFrame(function(chatFrame)
		self:UpdateFont(chatFrame)
	end)
end
