--- @class Private
local Private = select(2, ...)

--- @class ButtonModule: AceModule
local ButtonModule = Private.Addon:NewModule("Button")

--- @class ChatFrameUtils
local ChatFrameUtils = Private.ChatFrameUtils

--- @class DatabaseUtils
local DatabaseUtils = Private.DatabaseUtils

--- Update the button properties for the chat.
function ButtonModule:UpdateButtonVisibilityForChat()
	local databaseButton = DatabaseUtils.GetChatTable("button")

	ChatFrameChannelButton:SetShown(databaseButton.isChannelButtonVisible)
	ChatFrameMenuButton:SetShown(databaseButton.isMenuButtonVisible)
end

--- Update the button properties for a chat frame.
--- @param chatFrame table
function ButtonModule:UpdateButtonVisibilityForChatFrame(chatFrame)
	local chatFrameId = ChatFrameUtils:GetChatFrameId(chatFrame)
	local databaseButton = DatabaseUtils.GetChatFramesTable(chatFrameId, "button")

	local buttonMap = {
		isBottomButtonVisible = chatFrame.buttonFrame.bottomButton,
		isDownButtonVisible = chatFrame.buttonFrame.downButton,
		isUpButtonVisible = chatFrame.buttonFrame.upButton,
	}

	for isVisible, button in pairs(buttonMap) do
		button:SetShown(databaseButton[isVisible])
	end
end

function ButtonModule:OnEnable()
	self:UpdateButtonVisibilityForChat()

	ChatFrameUtils:ForEachChatFrame(function(chatFrame)
		self:UpdateButtonVisibilityForChatFrame(chatFrame)
	end)
end
