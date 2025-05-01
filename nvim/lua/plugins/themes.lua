-- themes.lua

return {
	{
		"maxmx03/dracula.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			local dracula = require("dracula")
			dracula.setup({
				styles = {
					Type = {},
					Function = {},
					Parameter = {},
					Property = {},
					Comment = {},
					String = {},
					Keyword = {},
					Identifier = {},
					Constant = {},
				},
				transparent = true,
				on_colors = function(colors, color)
					return {
						mycolor = "#ffffff",
					}
				end,
				on_highlights = function(colors, color)
					return {
						Normal = { fg = colors.mycolor },
					}
				end,
				plugins = {
					["nvim-treesitter"] = true,
					["nvim-lspconfig"] = true,
					["nvim-cmp"] = true,
					["gitsigns.nvim"] = true,
					["todo-comments.nvim"] = true,
					["lazy.nvim"] = true,
					["telescope.nvim"] = true,
				},
			})
			vim.cmd.colorscheme("dracula")
		end,
	},
	{
		"nvim-lualine/lualine.nvim",
		opts = {
			options = {
				theme = vim.g.colors_name,
				refresh = {
					statusline = 1000,
				},
			},
		},
	},
}
