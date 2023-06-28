local _, Private = ...

local DatabaseUtils = Private:CreateTable({ "Utils", "Database" })

function DatabaseUtils.getChatTable(key)
	return Private:GetTable({ "db", "profile", "chat", key })
end

function DatabaseUtils.getChatFramesTable(chatFrameId, key)
	return Private:GetTable({ "db", "profile", "chatFrames", chatFrameId, key })
end
