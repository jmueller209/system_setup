-- lua/plugins/bookmarks.lua
return {
	"heilgar/bookmarks.nvim",
	dependencies = {
		"kkharji/sqlite.lua",
		"nvim-lua/plenary.nvim",
		"nvim-telescope/telescope.nvim",
	},
	config = function()
		require("bookmarks").setup({
			db_path = vim.fn.stdpath("data") .. "/bookmarks.db",
			use_branch_specific = false,
			default_mappings = true,
		})
		require("telescope").load_extension("bookmarks")
	end,
	keys = {
		-- Basic actions
		{ "<leader>ba", "<cmd>BookmarkAdd<cr>", desc = "Add Bookmark" },
		{ "<leader>br", "<cmd>BookmarkRemove<cr>", desc = "Remove Bookmark" },
		{ "<leader>bl", "<cmd>Bookmarks<cr>", desc = "List Bookmarks" },
		{ "<leader>bj", "<cmd>lua require('bookmarks.navigation').jump_to_next()<cr>", desc = "Next Bookmark" },
		{ "<leader>bk", "<cmd>lua require('bookmarks.navigation').jump_to_prev()<cr>", desc = "Previous Bookmark" },
	},
}
