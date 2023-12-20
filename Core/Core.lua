--- @type string
local AddonName = select(1, ...)

--- @class Private
local Private = select(2, ...)

--- @class Addon: AceAddon
local Addon = Private.Addon

--- @class ChatFrameHooks
local ChatFrameHooks = Private.ChatFrameHooks

function Addon:OnInitialize()
	--- @class AceDBObject-3.0
	Private.db = LibStub("AceDB-3.0"):New(AddonName .. "DB", Private.Database:GetDatabaseDefaults(), true)

	Private.Options:Initialize()
end

function Addon:OnEnable()
	ChatFrameHooks:Initialize()
end
