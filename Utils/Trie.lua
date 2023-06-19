local _, Private = ...

local TrieUtils = Private:CreateTable({ "Utils", "Trie" })

function TrieUtils.newTrie()
	return {
		isWordComplete = false,
	}
end

function TrieUtils.insertTrie(currentTrie, wordToInsert)
	if not currentTrie then
		currentTrie = TrieUtils.newTrie()
	end

	local currentNode = currentTrie
	local wordLength = #wordToInsert

	for charIndex = 1, wordLength do
		local currentChar = wordToInsert:sub(charIndex, charIndex)
		local nextNode = currentNode[currentChar]

		if not nextNode then
			nextNode = {}
			currentNode[currentChar] = nextNode
		end

		currentNode = nextNode
	end

	currentNode.isWordComplete = true

	return currentTrie
end

function TrieUtils.searchTrie(currentTrie, wordToSearch, exactMatch)
	if not currentTrie then
		return false
	end

	local currentNode = currentTrie
	local wordLength = #wordToSearch

	for charIndex = 1, wordLength do
		local currentChar = wordToSearch:sub(charIndex, charIndex)
		local nextNode = currentNode[currentChar]

		if not nextNode then
			if not exactMatch and currentNode.isWordComplete then
				return true
			else
				return false
			end
		end

		currentNode = nextNode
	end

	return currentNode.isWordComplete
end
