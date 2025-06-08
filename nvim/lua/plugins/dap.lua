-- dap.lua

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
			ensure_installed = { "delve" },
			automatic_installation = true,
		})

		local dap = require("dap")
    -- Breakpoint 
    vim.fn.sign_define("DapBreakpoint", { text = "", texthl = "DapBreakpoint" })
		vim.api.nvim_set_hl(0, "DapBreakpoint", { fg = "red" })

    -- Widget Window
  		local dapui = require("dapui")
		dapui.setup({
			floating = {
				max_height = 0.25,
				max_width = 0.4,
				border = "rounded",
				mappings = {
					close = { "q", "<Esc>" },
				},
			},
			layouts = {},
		})
		
		local current_float_win = nil
		local current_float_buf = nil
		
		local function close_window()
			if current_float_win and vim.api.nvim_win_is_valid(current_float_win) then
				vim.api.nvim_win_close(current_float_win, true)
			end
			if current_float_buf and vim.api.nvim_buf_is_valid(current_float_buf) then
				vim.api.nvim_buf_delete(current_float_buf, { force = true })
			end
			current_float_win = nil
			current_float_buf = nil
		end
		
		local function show_variable()
			close_window()
			dapui.float_element("scopes", { enter = false })
		end
		
		dap.listeners.after.event_stopped["custom_float"] = function() show_variable() end
		dap.listeners.before.event_terminated["custom_float"] = function() close_window() end
		dap.listeners.before.event_exited["custom_float"] = function() close_window() end

    -- Go Lang Configuration
    dap.adapters.go = { type = "server", port = "${port}",
      executable = { command = vim.fn.stdpath("data") .. "/mason/packages/delve/dlv", 
      args = { "dap", "-l", "127.0.0.1:${port}" } },
    }

    dap.configurations.go = {
      { type = "go", name = "Debug File", request = "launch", program = "${file}" },
      { type = "go", name = "Debug Test", request = "launch", mode = "test", program = "${file}" },
      { type = "go", name = "Debug Directory", request = "launch", program = "${fileDirname}" },
      { type = "go", name = "Debug Workspace", request = "launch", program = "${workspaceFolder}" },
    }

    -- Keymaps
		vim.keymap.set("n", "<Leader>ds", function() require("dap").continue() end, 
    { noremap = true, silent = true, desc = "DAP: Start Debugging" })
    vim.keymap.set("n", "<Leader>dq", function() require("dap").terminate()	
    require("dap").close() close_window() end,
    { noremap = true, silent = true, desc = "DAP: Quit Debugging" })
    vim.keymap.set("n", "<Leader>dv", function() show_variable() end, 
    { noremap = true, silent = true, desc = "DAP: Show Current Variable" })
		vim.keymap.set("n", "<Leader>dp", function() require("dap").step_over() end,
    { noremap = true, silent = true, desc = "DAP: Step Over" })
		vim.keymap.set("n", "<Leader>di", function() require("dap").step_into() end, 
    { noremap = true, silent = true, desc = "DAP: Step Into" })
		vim.keymap.set("n", "<Leader>do", function() require("dap").step_out() end, 
    { noremap = true, silent = true, desc = "DAP: Step Out" })
		vim.keymap.set("n", "<Leader>db", function() require("dap").toggle_breakpoint() end, 
    { noremap = true, silent = true, desc = "DAP: Toggle Breakpoint" })
	end,
}
