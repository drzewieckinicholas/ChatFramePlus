local ipairs = ipairs

local _, Private = ...

function Private:CreateTable(keys)
	for _, key in ipairs(keys) do
		self[key] = self[key] or {}
		self = self[key]
	end

	return self
end

function Private:GetTable(keys)
	for _, key in ipairs(keys) do
		if not self[key] then
			return nil
		end

		self = self[key]
	end

	return self
end
