local AceAddon = LibStub("AceAddon-3.0")

--- @type string
local AddonName = select(1, ...)

--- @class Private
local Private = select(2, ...)

--- @class Addon: AceAddon
local Addon = {}

Addon = AceAddon:NewAddon(AddonName)

Private.Addon = Addon
