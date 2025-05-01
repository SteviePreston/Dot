-- glow-md.lua

return {
	"ellisonleao/glow.nvim",
	cmd = "Glow",
	config = function()
		require("glow").setup({
			style = "dark", -- "dark" or "light"
			width = 120, -- Set floating window width
			height = 40, -- Set floating window height
			border = "rounded", -- Border style: "none", "single", "double", "rounded"
			pager = false, -- Disable scrolling inside Glow
		})
	end,
	keys = {
		{ "<leader>md", "<cmd>Glow<cr>", desc = "Glow Preview Markdown" },
	},
}
