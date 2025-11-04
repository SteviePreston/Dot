-- glow-md.lua

return {
	"ellisonleao/glow.nvim",
	cmd = "Glow",
	config = function()
		require("glow").setup({
			style = "dark", 
			width = math.floor(vim.o.columns * 0.95),
			height = math.floor(vim.o.lines * 0.85),
			border = "rounded",
			pager = false, 
		})
	end,
	keys = {
		{ "<leader>md", "<cmd>Glow<cr>", desc = "Glow Preview Markdown" },
	},
}
