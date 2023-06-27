local _, Private = ...

local ButtonModule = Private.Addon:NewModule("Button")

local ChatFrameUtils = Private.Utils.ChatFrame
local DatabaseUtils = Private.Utils.Database

local buttonTables = setmetatable({}, {
	__index = function(buttonTableCache, chatFrameId)
		local buttonTable = DatabaseUtils.getChatFramesTable(chatFrameId, "button")

		buttonTableCache[chatFrameId] = buttonTable

		return buttonTable
	end,
})

function ButtonModule:UpdateButtonVisibilityForFrame(chatFrame, buttonToUpdate)
	local chatFrameId = ChatFrameUtils.getChatFrameId(chatFrame)

	local buttons = {
		bottomButton = {
			button = chatFrame.buttonFrame.bottomButton,
			key = "isBottomButtonVisible",
		},
		downButton = {
			button = chatFrame.buttonFrame.downButton,
			key = "isDownButtonVisible",
		},
		upButton = {
			button = chatFrame.buttonFrame.upButton,
			key = "isUpButtonVisible",
		},
	}

	local buttonInfo = buttons[buttonToUpdate]

	if buttonInfo then
		local buttonTable = buttonTables[chatFrameId]

		buttonInfo.button:SetShown(buttonTable[buttonInfo.key])
	end
end

function ButtonModule:UpdateAllButtonVisibilityForFrame(chatFrame)
	self:UpdateButtonVisibilityForFrame(chatFrame, "bottomButton")
	self:UpdateButtonVisibilityForFrame(chatFrame, "downButton")
	self:UpdateButtonVisibilityForFrame(chatFrame, "upButton")
end

function ButtonModule:OnEnable()
	ChatFrameUtils.forEachChatFrame(function(chatFrame)
		self:UpdateAllButtonVisibilityForFrame(chatFrame)
	end)
end
