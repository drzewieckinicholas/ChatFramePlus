--- @class Private
local Private = select(2, ...)

--- @class MessageUtils
local MessageUtils = {}

--- Returns the protected id if the provided string is empty.
--- @param potentialProtectedString string
--- @param fallbackId string
--- @return string?
local function extractProtectedId(potentialProtectedString, fallbackId)
	if fallbackId and potentialProtectedString == "" then
		return fallbackId
	end
end

--- Returns true if the message is protected.
--- @param message string
--- @return boolean
function MessageUtils.IsMessageProtected(message)
	return message and (message ~= gsub(message, "(:?|?)|K(.-)|k", extractProtectedId))
end

Private.MessageUtils = MessageUtils
