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

function ButtonModule:UpdateButtonVisibility(chatFrame, buttonToUpdate)
	local chatFrameId = chatFrame and ChatFrameUtils.getChatFrameId(chatFrame)

	local buttons = {
		channelButton = {
			button = ChatFrameChannelButton,
			key = "isChannelButtonVisible",
		},
		menuButton = {
			button = ChatFrameMenuButton,
			key = "isMenuButtonVisible",
		},
		bottomButton = {
			button = chatFrame and chatFrame.buttonFrame.bottomButton,
			key = "isBottomButtonVisible",
		},
		downButton = {
			button = chatFrame and chatFrame.buttonFrame.downButton,
			key = "isDownButtonVisible",
		},
		upButton = {
			button = chatFrame and chatFrame.buttonFrame.upButton,
			key = "isUpButtonVisible",
		},
	}

	local buttonInfo = buttons[buttonToUpdate]

	if buttonInfo then
		local buttonTable = chatFrameId and buttonTables[chatFrameId] or DatabaseUtils.getChatTable("button")

		buttonInfo.button:SetShown(buttonTable[buttonInfo.key])
	end
end

function ButtonModule:UpdateFrameButtonVisibility(chatFrame)
	self:UpdateButtonVisibility(chatFrame, "bottomButton")
	self:UpdateButtonVisibility(chatFrame, "downButton")
	self:UpdateButtonVisibility(chatFrame, "upButton")
end

function ButtonModule:OnEnable()
	self:UpdateButtonVisibility(nil, "channelButton")
	self:UpdateButtonVisibility(nil, "menuButton")

	ChatFrameUtils.forEachChatFrame(function(chatFrame)
		self:UpdateFrameButtonVisibility(chatFrame)
	end)
end
