-- dap.lua

return {
	"mfussenegger/nvim-dap",
	dependencies = {
		"jay-babu/mason-nvim-dap.nvim",
		"williamboman/mason.nvim",
		"theHamsta/nvim-dap-virtual-text", 
	},
	config = function()
		require("mason").setup()
		require("mason-nvim-dap").setup({
			ensure_installed = { "delve", "debugpy", "js-debug-adapter" },
			automatic_installation = true,
		})

		local function set_dap_colors()
			vim.api.nvim_set_hl(0, "NvimDapVirtualText", {
                fg = vim.api.nvim_get_hl_by_name("DiagnosticInfo", true).foreground,
				bold = true,
                italic = true,
                reverse = true,
			})
			
            vim.api.nvim_set_hl(0, "NvimDapVirtualTextChanged", {
                fg = vim.api.nvim_get_hl_by_name("DiagnosticWarn", true).foreground,
				bold = true,
                italic = true,
                reverse = true,
			})

			vim.api.nvim_set_hl(0, "NvimDapVirtualTextError", {
                fg = vim.api.nvim_get_hl_by_name("DiagnosticError", true).foreground,
				bold = true,
                italic = true,
                reverse = true,
			})
		end
		
		-- Initalize Dap Colors
		set_dap_colors()
		vim.api.nvim_create_autocmd("ColorScheme", {
			callback = set_dap_colors,
			desc = "Update DAP virtual text highlights on colorscheme change"
		})
		
		-- Setup virtual text
        require("nvim-dap-virtual-text").setup({
			enabled = true,
			enabled_commands = true,
			highlight_changed_variables = true,
			highlight_new_as_changed = true,
			show_stop_reason = true,
			commented = false,
			only_first_definition = true,
			all_references = false,
			clear_on_continue = false,
			
			display_callback = function(variable, buf, stackframe, node)
				return " → " .. variable.value
			end,
		})
		
		local dap = require("dap")
		
		-- Minimal breakpoint styling
        vim.fn.sign_define("DapBreakpoint", { text = "", texthl = "DapBreakpoint" })
        vim.api.nvim_set_hl(0, "DapBreakpoint", { fg = "red" })
        vim.fn.sign_define("DapStopped", { text = "▶", texthl = "DapStopped" })
        vim.api.nvim_set_hl(0, "DapStopped", { fg = "red" })
		
		-- Go configuration
		dap.adapters.go = { 
			type = "server", 
			port = "${port}",
			executable = { 
				command = vim.fn.stdpath("data") .. "/mason/packages/delve/dlv", 
				args = { "dap", "-l", "127.0.0.1:${port}" } 
			},
		}
		
		dap.configurations.go = {
			{ type = "go", name = "Debug File", request = "launch", program = "${file}" },
			{ type = "go", name = "Debug Test", request = "launch", mode = "test", program = "${file}" },
			{ type = "go", name = "Debug Directory", request = "launch", program = "${fileDirname}" },
		}

        -- TODO: Configure debugpy
        -- TODO: Configure js-debug-adapter
		
		-- Minimal keymaps
		vim.keymap.set("n", "<Leader>ds", dap.continue, { desc = "DAP: Start/Continue" })
		vim.keymap.set("n", "<Leader>dq", function() dap.terminate() dap.close() end, { desc = "DAP: Quit" })
		vim.keymap.set("n", "<Leader>dp", dap.step_over, { desc = "DAP: Step Over" })
		vim.keymap.set("n", "<Leader>di", dap.step_into, { desc = "DAP: Step Into" })
		vim.keymap.set("n", "<Leader>do", dap.step_out, { desc = "DAP: Step Out" })
		vim.keymap.set("n", "<Leader>db", dap.toggle_breakpoint, { desc = " DAP: Toggle Breakpoint" })
	end,
}
