-- themes.lua

return {
    "ellisonleao/gruvbox.nvim",
    priority = 1000,
    lazy = true,
    config = function()
        require("gruvbox").setup({
        terminal_colors = true,
        undercurl = true,
        underline = true,
        bold = true,
        italic = {
            strings = true,
            emphasis = true,
            comments = true,
            operators = false,
            folds = true,
        },
        strikethrough = true,
        contrast = "hard",
        dim_inactive = false,
        transparent_mode = true,
        })
        vim.cmd("colorscheme gruvbox")
    end,
}
