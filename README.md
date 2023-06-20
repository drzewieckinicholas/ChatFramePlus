[![Commitizen friendly](https://img.shields.io/badge/commitizen-friendly-brightgreen.svg)](http://commitizen.github.io/cz-cli/)

# ChatFramePlus

ChatFramePlus is an addon for World of Warcraft: Classic and Wrath of the Lich King: Classic that provides further customization of chat frames.

## Quick Start

ChatFramePlus options are available in the base World of Warcraft `Interface Options` window under the `AddOns` tab.

## Features

* Copy chat messages by holding `Ctrl` and clicking `Left Mouse Button` on a chat tab
* Filter out chat messages using your provided filter words
* Customize the name, size, and style of the font

## Techniques

### Filter

The filter feature builds a trie from your filter words.

```lua
ChatFramePlusDB = {
	["filterWordsTrie"] = {
		["isWordComplete"] = false,
		["c"] = {
			["a"] = {
				["r"] = {
					["r"] = {
						["y"] = {
							["isWordComplete"] = true,
						},
					},
				},
			},
		},
		["b"] = {
			["i"] = {
				["d"] = {
					["isWordComplete"] = true,
				},
			},
			["o"] = {
				["o"] = {
					["s"] = {
						["t"] = {
							["isWordComplete"] = true,
						},
					},
				},
			},
		},
	},
}
```

Incoming chat messages are split into words and each word is searched against the trie. If any word matches a word in the trie, the chat message is filtered out.
