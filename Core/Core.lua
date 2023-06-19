local AddonName, Private = ...

local ChatFramePlus = LibStub("AceAddon-3.0"):GetAddon(AddonName)

local ChatFrameHooks = Private.Hooks.ChatFrame

function ChatFramePlus:OnInitialize()
	Private.db = LibStub("AceDB-3.0"):New(AddonName .. "DB", Private:GetDatabaseDefaults(), true)

	Private.Options:Init()
end

function ChatFramePlus:OnEnable()
	ChatFramePlus:EnableModule("Font")

	ChatFrameHooks:Init()
end
