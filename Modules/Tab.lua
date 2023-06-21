local ipairs, pairs = ipairs, pairs

local _, Private = ...

local TabModule = Private.Addon:NewModule("Tab")

local TabConstants = Private.Constants.Tab

local ChatFrameUtils = Private.Utils.ChatFrame
local DatabaseUtils = Private.Utils.Database

local chatTabTextures = setmetatable({}, {
	__index = function(t, chatFrame)
		local textures = {}

		for _, texture in ipairs(TabConstants.TEXTURES) do
			textures[texture] = ChatFrameUtils.getChatTabTexture(chatFrame, texture)
		end

		t[chatFrame] = textures

		return textures
	end,
})

local function updateTexturesVisibility(textures, isVisible)
	local alpha = isVisible and 1 or 0

	for _, textureFrame in pairs(textures) do
		if textureFrame then
			textureFrame:SetAlpha(alpha)
		end
	end
end

function TabModule:UpdateTab(chatFrame)
	local chatFrameId = ChatFrameUtils.getChatFrameId(chatFrame)
	local tabTable = DatabaseUtils.getChatFramesTable(chatFrameId, "tab")
	local tabTextures = chatTabTextures[chatFrame]

	updateTexturesVisibility(tabTextures, tabTable.isBackgroundVisible)
end

function TabModule:OnEnable()
	ChatFrameUtils.forEachChatFrame(function(chatFrame)
		self:UpdateTab(chatFrame)
	end)
end
