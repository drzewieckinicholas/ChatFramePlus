local concat = table.concat

local AceGUI = LibStub("AceGUI-3.0")

local _, Private = ...

local CopyModule = Private.Addon:NewModule("Copy")

local CopyConstants = Private.Constants.Copy

local ChatFrameUtils = Private.Utils.ChatFrame

function CopyModule:OnTextChangedCallback(widget, userInput)
	if not userInput then
		return
	end

	local currentMessage = self.currentCopyFrame and self.currentCopyFrame.text or ""

	if widget:GetText() == currentMessage then
		return
	end

	local cursorPosition = widget:GetCursorPosition()

	widget:SetText(currentMessage)
	widget:SetCursorPosition(cursorPosition)
end

function CopyModule:OnCloseCallback(widget)
	AceGUI:Release(widget)

	self.currentCopyFrame = nil
end

function CopyModule:HandleKeyInput(widget, key)
	local shouldPropagate = key ~= "ESCAPE"

	widget:SetPropagateKeyboardInput(shouldPropagate)

	if not shouldPropagate and self.currentCopyFrame then
		self.currentCopyFrame.frame:Hide()
	end
end

function CopyModule:SetKeyHandler(element)
	element:EnableKeyboard(true)
	element:SetScript("OnKeyDown", function(...)
		self:HandleKeyInput(...)
	end)
	element:SetPropagateKeyboardInput(true)
end

function CopyModule:SetupFrame(copyFrame)
	copyFrame:SetTitle(CopyConstants.FRAME_TITLE)
	copyFrame:SetLayout(CopyConstants.FRAME_LAYOUT)
	copyFrame:SetWidth(CopyConstants.FRAME_WIDTH)
	copyFrame:SetHeight(CopyConstants.FRAME_HEIGHT)
	copyFrame:SetCallback("OnClose", function(...)
		self:OnCloseCallback(...)
	end)
	copyFrame.frame:SetClampedToScreen(true)
	copyFrame.frame:SetFrameStrata(CopyConstants.FRAME_STRATA)

	self:SetKeyHandler(copyFrame.frame)
end

function CopyModule:SetupMultiLineEditBox(multiLineEditBox)
	multiLineEditBox:SetLabel(nil)
	multiLineEditBox:DisableButton(true)
	multiLineEditBox:SetCallback("OnTextChanged", function(...)
		self:OnTextChangedCallback(...)
	end)

	self:SetKeyHandler(multiLineEditBox.editBox)
end

function CopyModule:CreateFrame()
	local copyFrame = AceGUI:Create("Frame")
	self:SetupFrame(copyFrame)

	local multiLineEditBox = AceGUI:Create("MultiLineEditBox")
	self:SetupMultiLineEditBox(multiLineEditBox)

	copyFrame:AddChild(multiLineEditBox)

	self.currentCopyFrame = {
		editBox = multiLineEditBox,
		frame = copyFrame,
		text = "",
	}

	return self.currentCopyFrame
end

function CopyModule:UpdateFrame(copyFrame, chatFrame)
	copyFrame.text = concat(ChatFrameUtils.getChatFrameMessages(chatFrame), "\n")
	copyFrame.editBox:SetText(copyFrame.text)

	if self.currentCopyFrame then
		C_Timer.After(0, function()
			self.currentCopyFrame.editBox:SetCursorPosition(#self.currentCopyFrame.text)
		end)
	end
end

function CopyModule:ShowFrame(chatFrame)
	self.currentCopyFrame = self.currentCopyFrame or self:CreateFrame()

	self:UpdateFrame(self.currentCopyFrame, chatFrame)

	self.currentCopyFrame.frame:Show()
end

function CopyModule:OnInitialize()
	self.currentCopyFrame = nil
end
