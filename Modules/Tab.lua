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
--- @param texturesForFrame table
--- @param isBackgroundVisible boolean
local function updateTexturesVisibility(texturesForFrame, isBackgroundVisible)
	local alpha = isBackgroundVisible and 1 or 0

	for _, texture in pairs(texturesForFrame) do
		texture:SetAlpha(alpha)
	end
end

--- Update the tab properties for a chat frame.
--- @param chatFrame table
function TabModule:UpdateTab(chatFrame)
	local chatFrameId = ChatFrameUtils:GetChatFrameId(chatFrame)
	local databaseTab = DatabaseUtils.GetChatFramesTable(chatFrameId, "tab")

	updateTexturesVisibility(textures[chatFrame], databaseTab.isBackgroundVisible)
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
		self:UpdateTab(chatFrame)
	end)
end
