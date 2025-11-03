-- copilot.lua

return {
    "github/copilot.vim",
    event = "InsertEnter",
    config = function()

        vim.g.copilot_no_tab_map = true
        
        vim.g.copilot_filetypes = {
            ["*"] = true,
            ["gitcommit"] = false,
            ["markdown"] = true,
            ["yaml"] = true,
        }
        
    end,
}
