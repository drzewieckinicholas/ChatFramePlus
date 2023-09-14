--- @class Private
local Private = select(2, ...)

--- @class BackgroundModule: AceModule
local BackgroundModule = Private.Addon:NewModule("Background")

--- @class BackgroundConstants
local BackgroundConstants = Private.BackgroundConstants

--- @class ChatFrameUtils
local ChatFrameUtils = Private.ChatFrameUtils

--- @class DatabaseUtils
local DatabaseUtils = Private.DatabaseUtils

--- @type table
local textures = {}

--- Updates the visibility of the background textures for a chat frame background.
--- @param chatFrame table
function BackgroundModule:UpdateBackgroundTextureVisibility(chatFrame)
	local chatFrameId = ChatFrameUtils:GetChatFrameId(chatFrame)
	local databaseBackground = DatabaseUtils.GetChatFramesTable(chatFrameId, "background")

	for _, texture in pairs(textures[chatFrame]) do
		texture:SetShown(databaseBackground.isBackgroundVisible)
	end
end

--- Updates the visibility of the background for a chat frame.
--- @param chatFrame table
function BackgroundModule:UpdateBackgroundVisibility(chatFrame)
	local chatFrameId = ChatFrameUtils:GetChatFrameId(chatFrame)
	local databaseBackground = DatabaseUtils.GetChatFramesTable(chatFrameId, "background")
	local background = ChatFrameUtils:GetChatFrameBackground(chatFrame)

	background:SetShown(databaseBackground.isBackgroundVisible)

	self:UpdateBackgroundTextureVisibility(chatFrame)
end

function BackgroundModule:OnInitialize()
	ChatFrameUtils:ForEachChatFrame(function(chatFrame)
		textures[chatFrame] = textures[chatFrame] or {}

		for _, textureSuffix in ipairs(BackgroundConstants.TEXTURES) do
			textures[chatFrame][textureSuffix] = ChatFrameUtils:GetChatFrameTexture(chatFrame, textureSuffix)
		end
	end)
end

function BackgroundModule:OnEnable()
	ChatFrameUtils:ForEachChatFrame(function(chatFrame)
		self:UpdateBackgroundVisibility(chatFrame)
	end)
end
