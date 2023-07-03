--- @class Private
local Private = select(2, ...)

--- @class TrieUtils
local TrieUtils = {}

--- Returns a new trie.
--- @return table
function TrieUtils:Create()
	return {
		isWordComplete = false,
	}
end

--- Inserts a word into the trie.
--- @param trie table
--- @param word string
--- @return table
function TrieUtils:InsertWord(trie, word)
	if not trie then
		trie = self:Create()
	end

	local node = trie

	for charIndex = 1, #word do
		local currentChar = word:sub(charIndex, charIndex)
		local nextNode = node[currentChar]

		if not nextNode then
			nextNode = self:Create()
			node[currentChar] = nextNode
		end

		node = nextNode
	end

	node.isWordComplete = true

	return trie
end

--- Returns true if the trie contains the word.
--- @param trie table
--- @param word string
--- @param isExactMatch boolean
--- @return boolean
function TrieUtils:ContainsWord(trie, word, isExactMatch)
	if not trie then
		return false
	end

	local node = trie

	for charIndex = 1, #word do
		local currentChar = word:sub(charIndex, charIndex)
		local nextNode = node[currentChar]

		if not nextNode then
			if not isExactMatch and node.isWordComplete then
				return true
			else
				return false
			end
		end

		node = nextNode
	end

	return node.isWordComplete
end

Private.TrieUtils = TrieUtils
