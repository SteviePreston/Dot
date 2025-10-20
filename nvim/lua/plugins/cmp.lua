-- cmp.lua

return {
    "saghen/blink.cmp",
    dependencies = { 
        "nvim-tree/nvim-web-devicons" 
    },
    version = "*",
    lazy = false,
    opts = {
        appearance = {
            use_nvim_cmp_as_default = true,
            nerd_font_variant = "mono",
        },

        completion = {
            menu = {
            border = "rounded",
            auto_show = true,
            draw = {
                columns = { { "kind_icon", gap = 1 }, { "label", "label_description", gap = 1 }, { "kind" } },
            },
        },

        documentation = {
            auto_show = true, auto_show_delay_ms = 200,
            window = {
                border = "rounded",
            },
        },

        accept = {
            auto_brackets = {
                enabled = true,
            },
        },

        ghost_text = {
            enabled = true,
        },
    },

        signature = {
            enabled = true,
            window = {
                border = "rounded",
            },
        },

        keymap = {
            preset = "none",
            ['<CR>'] = { 'select_and_accept', 'fallback' },
            ["<C-k>"] = { "select_prev", "fallback" },
            ["<C-j>"] = { "select_next", "fallback" },
            ["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
            ["<C-u>"] = { "scroll_documentation_up", "fallback" },
            ["<C-d>"] = { "scroll_documentation_down", "fallback" },
            ['<Tab>'] = { 'snippet_forward', 'fallback' },
            ['<S-Tab>'] = { 'snippet_backward', 'fallback' },
        },

        sources = {
            default = { "lsp", "path", "snippets" }, 
        },

        cmdline = {
            enabled = true,
            sources = function()
                local type = vim.fn.getcmdtype()
                if type == "/" or type == "?" then
                    return { "buffer" }
                end
                if type == ":" then
                    return { "cmdline", "path" }
                end
                return {}
                end,
        },
    },
}
