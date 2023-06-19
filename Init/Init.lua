local ipairs = ipairs

local LibStub = LibStub

local AddonName, Private = ...

LibStub("AceAddon-3.0"):NewAddon(AddonName)

function Private:GetAddon()
	return LibStub("AceAddon-3.0"):GetAddon(AddonName)
end

function Private:CreateTable(keys)
	for _, key in ipairs(keys) do
		self[key] = self[key] or {}
		self = self[key]
	end
	return self
end
