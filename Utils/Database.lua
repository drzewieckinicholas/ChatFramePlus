local _, Private = ...

local DatabaseUtils = Private:createTable({ "Utils", "Database" })

local function getTableByType(tableName, index, type)
	local db = Private.db
	local parentTable = db and db.profile[tableName]
	local subTable = parentTable and parentTable[index]

	return subTable and subTable[type]
end

function DatabaseUtils.getTable(tableName)
	return function(index, type)
		return getTableByType(tableName, index, type)
	end
end

function DatabaseUtils.getChatFramesTable(index, type)
	return DatabaseUtils.getTable("chatFrames")(index, type)
end
