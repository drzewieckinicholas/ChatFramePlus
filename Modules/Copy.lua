--- @diagnostic disable: undefined-field

local AceGUI = LibStub("AceGUI-3.0")

--- @class Private
local Private = select(2, ...)

--- @class CopyModule: AceModule
local CopyModule = Private.Addon:NewModule("Copy")

--- @class CopyConstants
local CopyConstants = Private.CopyConstants

--- @class ChatFrameUtils
local ChatFrameUtils = Private.ChatFrameUtils

--- @class ColorUtils
local ColorUtils = Private.ColorUtils

--- @class DatabaseUtils
local DatabaseUtils = Private.DatabaseUtils

--- @class MessageUtils
local MessageUtils = Private.MessageUtils

local frame = nil

local multiLineEditBox = nil

--- @type string
local multiLineEditBoxText = ""

--- Handles the OnClose callback for the frame.
local function frameOnCloseCallback()
	AceGUI:Release(frame)
	frame = nil
end

--- Creates a frame.
local function createFrame()
	--- @class AceGUIFrame : AceGUIContainer
	frame = AceGUI:Create("Frame")
	frame:EnableResize(false)
	frame:SetTitle(CopyConstants.FRAME_TITLE)
	frame:SetWidth(CopyConstants.FRAME_WIDTH)
	frame:SetHeight(CopyConstants.FRAME_HEIGHT)
	frame:SetLayout(CopyConstants.FRAME_LAYOUT)
	frame.frame:SetClampedToScreen(true)
	frame.frame:SetFrameStrata(CopyConstants.FRAME_STRATA)
	frame:SetCallback("OnClose", frameOnCloseCallback)
end

--- Handles the OnTextChanged callback for the multi-line edit box.
--- @param widget AceGUIWidget
local function multiLineEditBoxOnTextChangedCallback(widget)
	local currentText = multiLineEditBoxText
	local cursorPosition = widget:GetCursorPosition()

	widget:SetText(currentText)
	widget:SetCursorPosition(cursorPosition)
end

--- Creates a multi-line edit box.
local function createMultiLineEditBox()
	--- @class AceGUIMultiLineEditBox : AceGUIWidget
	multiLineEditBox = AceGUI:Create("MultiLineEditBox")
	multiLineEditBox:DisableButton(true)
	multiLineEditBox:SetLabel("")
	multiLineEditBox:SetText("")
	multiLineEditBox:SetCallback("OnTextChanged", multiLineEditBoxOnTextChangedCallback)
end

--- Initializes the copy frame.
local function initializeCopyFrame()
	createFrame()
	createMultiLineEditBox()

	frame:AddChild(multiLineEditBox)
end

--- Updates the multi-line edit box text.
--- @param chatFrame table
local function updateMultiLineEditBoxText(chatFrame)
	multiLineEditBoxText = ""

	ChatFrameUtils:ForEachChatFrameMessage(chatFrame, function(text, r, g, b)
		--- Protected messages causes the multi-line edit box to display no text.
		if not MessageUtils.IsMessageProtected(text) then
			local hexColor = ColorUtils.RGBToHex(r, g, b)

			multiLineEditBoxText = multiLineEditBoxText .. hexColor .. text .. "|r\n"
		end
	end)

	multiLineEditBox.editBox:Insert(multiLineEditBoxText)

	--- Necessary to reliably scroll to the bottom of the multi-line edit box.
	C_Timer.After(0, function()
		multiLineEditBox:SetCursorPosition(#multiLineEditBoxText)
	end)
end

--- Shows the copy frame.
--- @param chatFrame table
function CopyModule:Show(chatFrame)
	if not frame then
		initializeCopyFrame()
	end

	updateMultiLineEditBoxText(chatFrame)

	frame:Show()
end
