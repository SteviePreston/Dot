-- lsp-config.lua

return {
	"neovim/nvim-lspconfig",
	dependencies = {
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		"hrsh7th/cmp-nvim-lsp",
		"nvimtools/none-ls.nvim",
		"jay-babu/mason-null-ls.nvim",
	},

	config = function()
		local lspconfig = require("lspconfig")
		local capabilities = require("cmp_nvim_lsp").default_capabilities()

		vim.diagnostic.config({
			virtual_text = false,
			float = { border = "rounded" },
			severity_sort = true,
		})

		local signs = {
			Error = "",
			Warn = "",
			Info = "",
			Hint = "",
		}

		for type, icon in pairs(signs) do
			local hl = "DiagnosticSign" .. type
			vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
		end

		vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show LSP Error Message" })
		vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Show all LSP diagnostics" })
		vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous LSP diagnostic" })
		vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next LSP diagnostic" })

		local on_attach = function(client, bufnr)
			if client.server_capabilities.documentFormattingProvider then
				vim.api.nvim_buf_set_option(bufnr, "formatexpr", "v:lua.vim.lsp.formatexpr()")
			end
		end

		local common_setup = { capabilities = capabilities, on_attach = on_attach, autostart = true }

		local null_ls = require("null-ls")
		null_ls.setup({
			sources = {
				null_ls.builtins.formatting.prettier,
				null_ls.builtins.formatting.black,
				null_ls.builtins.formatting.gofmt,
				null_ls.builtins.formatting.terraform_fmt,
				null_ls.builtins.formatting.clang_format,
			},
			on_attach = on_attach,
		})

		require("mason").setup()

		require("mason-null-ls").setup({
			ensure_installed = {
				"gofmt",
				"prettier",
				"black",
				"terraform_fmt",
				"clang-format",
			},
			automatic_installation = true,
		})

		require("mason-lspconfig").setup({
			ensure_installed = {
				"gopls",
				"pyright",
				"ts_ls",
				"terraformls",
				"clangd",
			},
			automatic_installation = true,
		})

		require("mason-lspconfig").setup_handlers({
			function(server_name)
				lspconfig[server_name].setup(common_setup)
			end,
		})

		vim.api.nvim_create_autocmd("CursorHold", {
			callback = function()
				vim.diagnostic.open_float(nil, { focusable = false })
			end,
		})
	end,
}
