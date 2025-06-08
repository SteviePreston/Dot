-- lsp-config.lua

return {
	"neovim/nvim-lspconfig",
	dependencies = {
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		"hrsh7th/cmp-nvim-lsp",
	},

	config = function()
		local lspconfig = require("lspconfig")
		local capabilities = require("cmp_nvim_lsp").default_capabilities()

    vim.diagnostic.config({
      virtual_lines = false,
      virtual_text = false,
      underline = true,
      update_in_insert = false,
      severity_sort = true,
      float = {
        border = "rounded",
        source = true,
        focusable = false,
        style = "minimal",
        max_width = 80,
        wrap = true,
      },
      signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = "󰅚 ",
            [vim.diagnostic.severity.WARN] = "󰀪 ",
            [vim.diagnostic.severity.INFO] = "󰋽 ",
            [vim.diagnostic.severity.HINT] = "󰌶 ",
        },
        numhl = {
            [vim.diagnostic.severity.ERROR] = "ErrorMsg",
            [vim.diagnostic.severity.WARN] = "WarningMsg",
        },
      },
    })

		vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous LSP diagnostic" })
		vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next LSP diagnostic" })

		local on_attach = function(client, bufnr)
			if client.server_capabilities.documentFormattingProvider then
				vim.api.nvim_buf_set_option(bufnr, "formatexpr", "v:lua.vim.lsp.formatexpr()")
			end
		end

		local common_setup = { capabilities = capabilities, on_attach = on_attach, autostart = true }

		require("mason").setup()
		require("mason-lspconfig").setup({
			ensure_installed = {
				"gopls",
				"pyright",
				"ts_ls",
				"terraformls",
			},
			automatic_installation = true,
		})

		vim.api.nvim_create_autocmd("CursorHold", {
			callback = function()
				vim.diagnostic.open_float(nil, { focusable = false })
			end,
		})

	end,
}
