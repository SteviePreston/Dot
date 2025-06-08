-- git-signs.lua

return {
	"lewis6991/gitsigns.nvim",
	dependencies = { "nvim-lua/plenary.nvim" },
	config = function()
		require("gitsigns").setup({
			signs = {
				add = { text = "▎" },
				change = { text = "▎" },
				delete = { text = "▎" },
				topdelete = { text = "▎" },
				changedelete = { text = "▎" },
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
		})
		-- Keybindings for Gitsigns
		vim.keymap.set("n", "<leader>gs", ":Gitsigns toggle_signs<CR>", { desc = "Toggle GitSigns" })
		vim.keymap.set("n", "<leader>gn", ":Gitsigns next_hunk<CR>", { desc = "Next Git Hunk" })
		vim.keymap.set("n", "<leader>gp", ":Gitsigns prev_hunk<CR>", { desc = "Previous Git Hunk" })
		vim.keymap.set("n", "<leader>gh", ":Gitsigns reset_hunk<CR>", { desc = "Reset Git Hunk" })
		vim.keymap.set("n", "<leader>gS", ":Gitsigns stage_hunk<CR>", { desc = "Stage Git Hunk" })
		vim.keymap.set("n", "<leader>gR", ":Gitsigns reset_buffer<CR>", { desc = "Reset Buffer" })
		vim.keymap.set("n", "<leader>gB", ":Gitsigns blame_line<CR>", { desc = "Blame Current Line" })
	end,
}
