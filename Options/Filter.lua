--- @class Private
local Private = select(2, ...)

--- @class FilterOptions
local FilterOptions = {}

--- @class FilterModule: AceModule
local FilterModule = Private.Addon:GetModule("Filter")

--- @class FilterConstants
local FilterConstants = Private.FilterConstants

--- @class DatabaseUtils
local DatabaseUtils = Private.DatabaseUtils

--- @class StringUtils
local StringUtils = Private.StringUtils

--- @class TrieUtils
local TrieUtils = Private.TrieUtils

--- @type function
local newLine = StringUtils.GenerateNewLine

--- Returns the filter options table for a chat frame.
--- @param chatFrame table
--- @param index number
--- @return table
function FilterOptions:CreateOptionsTableForChatFrame(chatFrame, index)
	local databaseFilter = DatabaseUtils.GetChatFramesTable(index, "filter")

	return {
		order = 4,
		type = "group",
		childGroups = "tab",
		name = FilterModule.moduleName,
		desc = "Filter options",
		args = {
			filterTogglesTab = {
				order = 1,
				type = "group",
				name = "Filter Toggles",
				args = {
					filterIsEnabled = {
						order = 1,
						type = "toggle",
						name = "Enabled",
						desc = "Toggle the filter on or off",
						width = "full",
						get = function(_)
							return databaseFilter.isEnabled
						end,
						set = function(_, value)
							databaseFilter.isEnabled = value
						end,
					},
					filterIsExactMatch = {
						order = 2,
						type = "toggle",
						name = "Exact Match",
						desc = function()
							return table.concat({
								"Enable to filter out messages where any word in the message exactly matches one of your filter words",
								"Disable to filter out messages where any word in the message partially matches one of your filter words",
							}, newLine(2))
						end,
						width = "full",
						get = function(_)
							return databaseFilter.isExactMatch
						end,
						set = function(_, value)
							databaseFilter.isExactMatch = value
						end,
					},
					filterIsShowFilteredMessages = {
						order = 3,
						type = "toggle",
						name = "Show Filtered Messages",
						desc = "Toggle the display of filtered messages in the chat frame",
						width = "full",
						get = function(_)
							return databaseFilter.isShowFilteredMessages
						end,
						set = function(_, value)
							databaseFilter.isShowFilteredMessages = value
						end,
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
							return table.concat({
								"Enter words to filter out messages from the chat frame",
								"Each word should be on a new line",
								"Words are case insensitive",
							}, newLine(2))
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
						get = function(_)
							return table.concat(databaseFilter.words, newLine(1))
						end,
						set = function(_, value)
							local words = {}
							local trie = TrieUtils:Create()
							local sanitizedWords = StringUtils.Sanitize(value)

							for word in sanitizedWords:gmatch("[^" .. newLine(1) .. "]+") do
								TrieUtils:InsertWord(trie, word)

								table.insert(words, word)
							end

							databaseFilter.words = words
							databaseFilter.trie = trie
						end,
					},
				},
			},
		},
	}
end

Private.FilterOptions = FilterOptions
