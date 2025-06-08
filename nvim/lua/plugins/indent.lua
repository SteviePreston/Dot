-- indent-blankline.lua

return {
	"lukas-reineke/indent-blankline.nvim",
	main = "ibl",
	opts = {
		indent = {
			char = "▏", -- Character for indentation guides
		},
		scope = {
			enabled = false,
		},
		exclude = {
			filetypes = {
				"help",
				"dashboard",
				"NvimTree",
				-- Add other filetypes to exclude if necessary
			},
		},
	},
}
