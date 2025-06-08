-- telescope.lua

return {
	"nvim-telescope/telescope.nvim",
	tag = "0.1.8",
	dependencies = { "nvim-lua/plenary.nvim" },
	config = function()
		require("telescope").setup({
			defaults = {
				path_display = { "smart" },
				layout_strategy = "vertical",
				layout_config = {
					 vertical = {
					 preview_height = 0.6,
					},
					width = 0.9,
					height = 0.9,
				},
			},
		})
		local builtin = require("telescope.builtin")
		-- Telescope Keybindings
		vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "TeleScope Find Files" })
		vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "TeleScope Find Live-Grep" })
		vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "TeleScope Find Buffers" })
		vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "TeleScope Find Help Tags" })
		vim.keymap.set("n", "<leader>fl", builtin.resume, { desc = "Telescope Resume Last Search" })

		vim.keymap.set("n", "lsd", builtin.lsp_definitions, { desc = "Telescope LSP Definitions" })
		vim.keymap.set("n", "lsr", builtin.lsp_references, { desc = "Telescope LSP References" })
		vim.keymap.set("n", "lsi", builtin.lsp_implementations, { desc = "Telescope LSP Implementations" })

		vim.keymap.set("n", "<leader>lsf", builtin.lsp_document_symbols, { desc = "Telescope LSP File Symbols" })
		vim.keymap.set("n", "<leader>lsg", builtin.lsp_workspace_symbols, { desc = "Telescope LSP Global Symbols" })
		vim.keymap.set("n", "<leader>lsq", builtin.quickfix, { desc = "Telescope Quickfix List" })
		vim.keymap.set("n", "<leader>lsd", builtin.diagnostics, { desc = "Telescope LSP Diagnostics" })

		vim.keymap.set("n", "<leader>gc", builtin.git_commits, { desc = "Telescope Git Commits" })
		vim.keymap.set("n", "<leader>gs", builtin.git_status, { desc = "Telescope Git Status" })
		vim.keymap.set("n", "<leader>gb", builtin.git_branches, { desc = "Telescope Git Branches" })

		vim.keymap.set("n", "<leader>km", builtin.keymaps, { desc = "Telescope Keymaps" })
		vim.keymap.set("n", "<leader>cmd", builtin.commands, { desc = "Telescope Commands" })
		vim.keymap.set("n", "<leader>ht", builtin.highlights, { desc = "Telescope Highlights" })
	end,
}
