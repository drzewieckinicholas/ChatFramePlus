local ipairs = ipairs

local AddonName, Private = ...

function Private:createTable(keys)
	for _, key in ipairs(keys) do
		self[key] = self[key] or {}
		self = self[key]
	end
	return self
end

function Private:getTable(keys)
	for _, key in ipairs(keys) do
		if not self[key] then
			return nil
		end
		self = self[key]
	end
	return self
end

LibStub("AceAddon-3.0"):NewAddon(AddonName)
