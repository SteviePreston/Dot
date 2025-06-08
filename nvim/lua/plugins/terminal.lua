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
				border = "curved", -- Options: "single", "double", "shadow", "curved"
			},
		})
	end,
}
