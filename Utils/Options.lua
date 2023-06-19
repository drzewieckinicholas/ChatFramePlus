local ipairs = ipairs

local _, Private = ...

local OptionsUtils = Private:CreateTable({ "Utils", "Options" })

function OptionsUtils.createGetter(tableFunc, keyPath, middleware)
	return function(info)
		local databaseTable = tableFunc(info)

		for _, key in ipairs(keyPath) do
			databaseTable = databaseTable[key]
		end

		if middleware then
			return middleware(databaseTable)
		end

		return databaseTable
	end
end

function OptionsUtils.createSetter(tableFunc, keyPath, middleware, updateFunc)
	return function(info, ...)
		local value = ...

		if middleware then
			value = middleware(...)
		end

		local databaseTable = tableFunc(info)

		for i = 1, #keyPath - 1 do
			databaseTable = databaseTable[keyPath[i]]
		end

		databaseTable[keyPath[#keyPath]] = value

		if updateFunc then
			updateFunc(info)
		end
	end
end

function OptionsUtils.createAccessors(tableFunc, keyPath, getMiddleware, setMiddleware, updateFunc)
	local createGetter = OptionsUtils.createGetter
	local createSetter = OptionsUtils.createSetter

	local get = createGetter(tableFunc, keyPath, getMiddleware)
	local set = createSetter(tableFunc, keyPath, setMiddleware, updateFunc)

	return get, set
end
