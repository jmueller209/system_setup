-- ~/.config/nvim/init.lua

-- Load general settings
require("config.settings")

-- Load keymaps
require("config.keymaps")

-- Bootstrap lazy.nvim
require("config.lazy")

-- Load plugins
require("lazy").setup("plugins", {
	ui = {
		icons = vim.g.have_nerd_font and {} or {
			cmd = "⌘",
			config = "🛠",
			event = "📅",
			ft = "📂",
			init = "⚙",
			keys = "🗝",
			plugin = "🔌",
			runtime = "💻",
			require = "🌙",
			source = "📄",
			start = "🚀",
			task = "📌",
			lazy = "💤 ",
		},
	},
})
