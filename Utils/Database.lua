--- @class Private
local Private = select(2, ...)

--- @class DatabaseUtils
local DatabaseUtils = {}

--- Returns a chat frame database table.
--- @param index number
--- @param key string
function DatabaseUtils.GetChatFramesTable(index, key)
	assert(type(index) == "number", "bad argument #1 expected number got " .. type(index))
	assert(type(key) == "string", "bad argument #2 expected string got " .. type(key))

	return Private.db.profile.chatFrames[index][key]
end

Private.DatabaseUtils = DatabaseUtils
