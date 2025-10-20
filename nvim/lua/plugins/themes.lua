-- themes.lua

return {
    {
        'sainnhe/gruvbox-material',
        lazy = false,
        priority = 1000,
        config = function()
            vim.g.gruvbox_material_enable_italic = true
            vim.g.gruvbox_material_transparent_background = 1
            vim.cmd.colorscheme('gruvbox-material')
            vim.api.nvim_set_hl(0, "@string.escape", { link = "Error", bold = true })
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
