-- git-signs.lua

return {
	"lewis6991/gitsigns.nvim",
	dependencies = { "nvim-lua/plenary.nvim" },
	config = function()
		require("gitsigns").setup({
			signs = {
				add = { text = "▌" },
				change = { text = "▌" },
				delete = { text = "▌" },
				topdelete = { text = "▌" },
				changedelete = { text = "▌" },
			},
			signcolumn = true,
			numhl = false, 
            linehl = false, 
			watch_gitdir = {
				interval = 1000,
				follow_files = true,
			},
			current_line_blame = true,
			current_line_blame_opts = {
				delay = 100,
			},
			current_line_blame_formatter = "<author> - <summary> (<author_time:%d-%m-%Y>)",
			max_file_length = 5000,
            preview_config = {
				border = "rounded",
				style = "minimal",
				relative = "cursor",
				row = 0,
				col = 1,
			},
		})
		
		-- Keybindings for Gitsigns
		vim.keymap.set("n", "]g", ":Gitsigns next_hunk<CR>", { desc = "GIT: Next Git Hunk" })
		vim.keymap.set("n", "[g", ":Gitsigns prev_hunk<CR>", { desc = "GIT: Previous Git Hunk" })

		vim.keymap.set("n", "<leader>gr", ":Gitsigns reset_hunk<CR>", { desc = "GIT: Reset Git Hunk" })
		vim.keymap.set("n", "<leader>gs", ":Gitsigns stage_hunk<CR>", { desc = "GIT: Stage Git Hunk" })
		vim.keymap.set("n", "<leader>gR", ":Gitsigns reset_buffer<CR>", { desc = "GIT: Reset Buffer" })

		vim.keymap.set("n", "<leader>gb", ":Gitsigns blame_line<CR>", { desc = "GIT: Blame Current Line" })
	end,
}
