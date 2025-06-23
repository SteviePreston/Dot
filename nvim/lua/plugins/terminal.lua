-- toggle-term.lua

return {
	"akinsho/toggleterm.nvim",
	version = "*",
	config = function()
		require("toggleterm").setup({
			open_mapping = [[<C-t>]], -- Press Ctrl+t to toggle terminal
			shade_terminals = true,
			direction = "float",
			float_opts = {
				border = "curved",
        			width = math.floor(vim.o.columns * 0.95),
				height = math.floor(vim.o.lines * 0.85),
			},
		})
	end,
}
