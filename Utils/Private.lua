local ipairs = ipairs

local AddonName, Private = ...

function Private:CreateTable(keys)
	for _, key in ipairs(keys) do
		self[key] = self[key] or {}
		self = self[key]
	end
	return self
end

function Private:GetAddon()
	return LibStub("AceAddon-3.0"):GetAddon(AddonName)
end
