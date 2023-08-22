--- @class Private
local Private = select(2, ...)

--- @class TabModule: AceModule
local TabModule = Private.Addon:NewModule("Tab")

--- @class TabConstants
local TabConstants = Private.TabConstants

--- @class ChatFrameUtils
local ChatFrameUtils = Private.ChatFrameUtils

--- @class DatabaseUtils
local DatabaseUtils = Private.DatabaseUtils

--- @type table
local textures = {}

--- Updates the visibility of the textures for a chat tab.
--- @param chatFrame table
function TabModule:UpdateTabTextureVisibility(chatFrame)
	local chatFrameId = ChatFrameUtils:GetChatFrameId(chatFrame)
	local databaseTab = DatabaseUtils.GetChatFramesTable(chatFrameId, "tab")
	local alpha = databaseTab.isBackgroundVisible and 1 or 0

	for _, texture in pairs(textures[chatFrame]) do
		texture:SetAlpha(alpha)
	end
end

function TabModule:OnInitialize()
	ChatFrameUtils:ForEachChatFrame(function(chatFrame)
		textures[chatFrame] = textures[chatFrame] or {}

		for _, textureSuffix in ipairs(TabConstants.TEXTURES) do
			textures[chatFrame][textureSuffix] = ChatFrameUtils:GetChatTabTexture(chatFrame, textureSuffix)
		end
	end)
end

function TabModule:OnEnable()
	ChatFrameUtils:ForEachChatFrame(function(chatFrame)
		self:UpdateTabTextureVisibility(chatFrame)
	end)
end
