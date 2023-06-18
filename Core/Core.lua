local AddonName, Private = ...

local ChatFramePlus = LibStub("AceAddon-3.0"):GetAddon(AddonName)

function ChatFramePlus:OnInitialize()
	print(AddonName .. ":OnInitialize")

	Private.db = LibStub("AceDB-3.0"):New(AddonName .. "DB", Private:GetDatabaseDefaults(), true)
end

function ChatFramePlus:OnEnable()
	print(AddonName .. ":OnEnable")
end

function ChatFramePlus:OnDisable()
	print(AddonName .. ":OnDisable")
end
