-- dap-config.lua

return {
	"mfussenegger/nvim-dap",
	dependencies = {
		"rcarriga/nvim-dap-ui",
		"nvim-neotest/nvim-nio",
		"jay-babu/mason-nvim-dap.nvim",
		"williamboman/mason.nvim",
		"nvim-telescope/telescope-dap.nvim",
	},
	config = function()
		require("mason").setup()
		require("mason-nvim-dap").setup({
			ensure_installed = {
				"python", -- Python
				"cppdbg", -- C/C++
				"delve", -- Go
				"js-debug-adapter", -- TypeScript
			},
			automatic_installation = true,
		})

		local dap = require("dap")
		vim.fn.sign_define("DapBreakpoint", { text = "", texthl = "DapBreakpoint" })
		vim.api.nvim_set_hl(0, "DapBreakpoint", { fg = "red" })
		local dapui = require("dapui")
		dapui.setup()

		dap.listeners.after.event_initialized["dapui_config"] = function()
			dapui.open()
		end
		dap.listeners.before.event_terminated["dapui_config"] = function()
			dapui.close()
		end
		dap.listeners.before.event_exited["dapui_config"] = function()
			dapui.close()
		end

		vim.keymap.set("n", "<Leader>dc", function()
			require("dap").continue()
		end, { noremap = true, silent = true, desc = "DAP: Start/Continue Debugging" })
		vim.keymap.set("n", "<Leader>dp", function()
			require("dap").step_over()
		end, { noremap = true, silent = true, desc = "DAP: Step Over" })
		vim.keymap.set("n", "<Leader>di", function()
			require("dap").step_into()
		end, { noremap = true, silent = true, desc = "DAP: Step Into" })
		vim.keymap.set("n", "<Leader>do", function()
			require("dap").step_out()
		end, { noremap = true, silent = true, desc = "DAP: Step Out" })
		vim.keymap.set("n", "<Leader>db", function()
			require("dap").toggle_breakpoint()
		end, { noremap = true, silent = true, desc = "DAP: Toggle Breakpoint" })
	end,
}
