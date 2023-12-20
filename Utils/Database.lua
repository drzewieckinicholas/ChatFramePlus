--- @class Private
local Private = select(2, ...)

--- @class DatabaseUtils
local DatabaseUtils = {}

--- Returns the chat database table.
--- @param key string
--- @return table
function DatabaseUtils.GetChatTable(key)
	assert(type(key) == "string", "bad argument #1 expected string got " .. type(key))

	return Private.db.profile.chat[key]
end

--- Returns a chat frame database table.
--- @param index number
--- @param key string
--- @return table
function DatabaseUtils.GetChatFramesTable(index, key)
	assert(type(index) == "number", "bad argument #1 expected number got " .. type(index))
	assert(type(key) == "string", "bad argument #2 expected string got " .. type(key))

	if not Private.db.profile.chatFrames[index] then
		Private.db.profile.chatFrames[index] = Private.Database.GetChatFrameDefaults()
	end

	return Private.db.profile.chatFrames[index][key]
end

Private.DatabaseUtils = DatabaseUtils
