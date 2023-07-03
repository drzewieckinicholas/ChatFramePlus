local AceGUI = LibStub("AceGUI-3.0")

--- @class Private
local Private = select(2, ...)

--- @class CopyModule: AceModule
local CopyModule = Private.Addon:NewModule("Copy")

--- @class CopyConstants
local CopyConstants = Private.CopyConstants

--- @class ChatFrameUtils
local ChatFrameUtils = Private.ChatFrameUtils

--- @class DatabaseUtils
local DatabaseUtils = Private.DatabaseUtils

--- @class CopyState
--- @field copyFrame table?
--- @field multiLineEditBox table?
--- @field text string?
local state = {
	copyFrame = nil,
	multiLineEditBox = nil,
	text = "",
}

--- Configures the copy frame.
local function configureCopyFrame(copyFrame)
	copyFrame:SetTitle(CopyConstants.FRAME_TITLE)
	copyFrame:SetWidth(CopyConstants.FRAME_WIDTH)
	copyFrame:SetHeight(CopyConstants.FRAME_HEIGHT)
	copyFrame:SetLayout(CopyConstants.FRAME_LAYOUT)
	copyFrame.frame:EnableKeyboard(true)
	copyFrame.frame:SetClampedToScreen(true)
	copyFrame.frame:SetFrameStrata(CopyConstants.FRAME_STRATA)
	copyFrame.frame:SetPropagateKeyboardInput(true)
end

--- Creates the copy frame.
local function createCopyFrame()
	local copyFrame = AceGUI:Create("Frame")

	configureCopyFrame(copyFrame)

	return copyFrame
end

--- Handles the text changing in the multi line edit box.
local function onTextChangedCallback(widget)
	local currentText = state.text
	local cursorPosition = widget:GetCursorPosition()

	widget:SetText(currentText)
	widget:SetCursorPosition(cursorPosition)
end

--- Configures the multi line edit box.
local function configureMultiLineEditBox(multiLineEditBox)
	multiLineEditBox:DisableButton(true)
	multiLineEditBox:SetLabel("")
	multiLineEditBox:SetCallback("OnTextChanged", onTextChangedCallback)
end

--- Creates the multi line edit box.
local function createMultiLineEditBox()
	local multiLineEditBox = AceGUI:Create("MultiLineEditBox")

	configureMultiLineEditBox(multiLineEditBox)

	return multiLineEditBox
end

--- Updates the copy frame with the chat frame messages.
--- @param chatFrame table
local function updateCopyFrame(chatFrame)
	state.text = table.concat(ChatFrameUtils:GetChatFrameMessages(chatFrame), "\n")
	state.multiLineEditBox:SetText(state.text)

	-- To scroll to the bottom of the multi line edit box, we need to wait.
	C_Timer.After(0, function()
		state.multiLineEditBox:SetCursorPosition(#state.text)
	end)
end

--- Closes the copy frame.
local function closeCopyFrame()
	state.copyFrame:Hide()

	AceGUI:Release(state.copyFrame)

	state.copyFrame = nil
end

--- Sets the escape key handler for a frame.
local function setEscapeKeyHandler(frame, editBox)
	frame:SetScript("OnKeyDown", function(self, key)
		if key ~= "ESCAPE" then
			self:SetPropagateKeyboardInput(true)

			return
		end

		closeCopyFrame()

		self:SetPropagateKeyboardInput(false)
	end)
end

--- Initializes the copy frame.
local function initializeCopyFrame()
	local copyFrame = createCopyFrame()
	local multiLineEditBox = createMultiLineEditBox()

	copyFrame:AddChild(multiLineEditBox)

	setEscapeKeyHandler(copyFrame.frame, multiLineEditBox.editBox)

	state.copyFrame = copyFrame
	state.multiLineEditBox = multiLineEditBox
	state.text = ""
end

--- Shows the copy frame.
--- @param chatFrame table
function CopyModule:ShowCopyFrame(chatFrame)
	if not state.copyFrame then
		initializeCopyFrame()
	end

	updateCopyFrame(chatFrame)

	state.copyFrame:Show()
	state.copyFrame.frame:SetPropagateKeyboardInput(true)
end
