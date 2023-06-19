local gmatch, concat, insert = string.gmatch, table.concat, table.insert

local _, Private = ...

local FilterOptions = Private:CreateTable({ "Options", "Filter" })

local FilterModule = Private.Addon:GetModule("Filter")

local DatabaseUtils = Private.Utils.Database
local OptionsUtils = Private.Utils.Options
local StringUtils = Private.Utils.String
local TrieUtils = Private.Utils.Trie

local createAccessors = OptionsUtils.createAccessors

local function processFilterWords(value)
	local filterWords = {}
	local filterWordsTrie = TrieUtils.newTrie()

	for word in gmatch(value, "[^\n]+") do
		word = StringUtils.sanitize(word)

		if word ~= "" then
			insert(filterWords, word)

			TrieUtils.insertTrie(filterWordsTrie, word)
		end
	end

	return filterWords, filterWordsTrie
end

function FilterOptions.getFilterOptions(index)
	local getFilterTable = function()
		return DatabaseUtils.getChatFramesTable(index, "filter")
	end

	local function getFilterWordsAsString(filterWords)
		return concat(filterWords, "\n")
	end

	local function setFilterWordsFromString(value)
		local filterWords, filterWordsTrie = processFilterWords(value)
		local filterTable = getFilterTable()

		filterTable.filterWords = filterWords
		filterTable.filterWordsTrie = filterWordsTrie

		return filterWords
	end

	local getFilterEnabled, setFilterEnabled =
		createAccessors(getFilterTable, { "isEnabled" })

	local getExactMatch, setExactMatch =
		createAccessors(getFilterTable, { "isExactMatch" })

	local getShowFilteredMessages, setShowFilteredMessages =
		createAccessors(getFilterTable, { "isShowFilteredMessages" })

	local getFilterWords, setFilterWords =
		createAccessors(getFilterTable, { "filterWords" }, getFilterWordsAsString, setFilterWordsFromString)

	return {
		order = 2,
		type = "group",
		childGroups = "tab",
		name = FilterModule.moduleName,
		desc = "Options for filtering chat messages",
		args = {
			filterTogglesTab = {
				order = 1,
				type = "group",
				name = "Filter Toggles",
				args = {
					filterEnabled = {
						order = 1,
						type = "toggle",
						name = "Enabled",
						desc = "Toggle chat message filtering on or off",
						width = "full",
						get = getFilterEnabled,
						set = setFilterEnabled,
					},
					exactMatch = {
						order = 2,
						type = "toggle",
						name = "Exact Match",
						desc = function()
							local descriptions = {
								"Enable to filter out messages where any word in the message exactly matches one of your filter words",
								"Disable to filter out messages where any word in the message partially matches one of your filter words",
							}

							return concat(descriptions, "\n\n")
						end,
						width = "full",
						get = getExactMatch,
						set = setExactMatch,
					},
					showFilteredMessages = {
						order = 3,
						type = "toggle",
						name = "Show Filtered Messages",
						desc = "Toggle whether or not to show filtered messages in the chat frame",
						width = "full",
						get = getShowFilteredMessages,
						set = setShowFilteredMessages,
					},
				},
			},
			filterWordsTab = {
				order = 2,
				type = "group",
				name = "Filter Words",
				args = {
					filterWordsDescription = {
						order = 1,
						type = "description",
						name = function()
							local descriptions = {
								"Enter words to filter out messages from the chat frame",
								"Each word should be on a new line",
								"Words are case insensitive",
							}

							return concat(descriptions, "\n\n")
						end,
						fontSize = "medium",
						width = "full",
					},
					filterWords = {
						order = 2,
						type = "input",
						name = "",
						width = "full",
						multiline = true,
						get = getFilterWords,
						set = setFilterWords,
					},
				},
			},
		},
	}
end
