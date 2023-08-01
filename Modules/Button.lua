--- @class Private
local Private = select(2, ...)

--- @class ButtonModule: AceModule
local ButtonModule = Private.Addon:NewModule("Button")

--- @class ChatFrameUtils
local ChatFrameUtils = Private.ChatFrameUtils

--- @class DatabaseUtils
local DatabaseUtils = Private.DatabaseUtils

--- Update the button properties for a chat frame.
--- @param chatFrame table
function ButtonModule:UpdateButtonVisibility(chatFrame)
	local chatFrameId = ChatFrameUtils:GetChatFrameId(chatFrame)
	local databaseButton = DatabaseUtils.GetChatFramesTable(chatFrameId, "button")

	local buttonMap = {
		isBottomButtonVisible = chatFrame.buttonFrame.bottomButton,
		isDownButtonVisible = chatFrame.buttonFrame.downButton,
		isUpButtonVisible = chatFrame.buttonFrame.upButton,
	}

	for isVisible, button in pairs(buttonMap) do
		if databaseButton[isVisible] then
			button:Show()
		else
			button:Hide()
		end
	end
end

function ButtonModule:OnEnable()
	ChatFrameUtils:ForEachChatFrame(function(chatFrame)
		self:UpdateButtonVisibility(chatFrame)
	end)
end
