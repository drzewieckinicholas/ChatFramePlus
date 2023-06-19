local gmatch = string.gmatch

local _, Private = ...

local FilterUtils = Private:CreateTable({ "Utils", "Filter" })

local FilterConstants = Private.Constants.Filter

local StringUtils = Private.Utils.String
local TrieUtils = Private.Utils.Trie

function FilterUtils.getChatMessageEvents()
	return FilterConstants.EVENTS
end

function FilterUtils.shouldFilterChatMessage(filterTable, message)
	if not filterTable.isEnabled then
		return false
	end

	local filterWordsTrie = filterTable.filterWordsTrie
	local exactMatch = filterTable.isExactMatch
	local sanitizedMessage = StringUtils.sanitize(message)

	for word in gmatch(sanitizedMessage, "%S+") do
		if TrieUtils.searchTrie(filterWordsTrie, word, exactMatch) then
			return true
		end
	end
end
