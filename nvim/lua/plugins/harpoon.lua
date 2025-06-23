-- harpoon.lua

return {
	"ThePrimeagen/harpoon",
	branch = "harpoon2",
	dependencies = { "nvim-lua/plenary.nvim" },
	config = function()
		local harpoon = require("harpoon")
		local mark = harpoon:list()
		local ui = harpoon.ui

		harpoon:setup({})

		vim.keymap.set("n", "<leader>ha", function()
			mark:add()
		end, { desc = "Harpoon: Add File" })
		vim.keymap.set("n", "<leader>hm", function()
			ui:toggle_quick_menu(mark)
		end, { desc = "Harpoon: Toggle" })
		vim.keymap.set("n", "<leader>ht", function()
			harpoon:list():next()
		end, { desc = "Harpoon Next File" })
		vim.keymap.set("n", "<leader>hp", function()
			harpoon:list():prev()
		end, { desc = "Harpoon Previous File" })

		vim.keymap.set("n", "<leader>h1", function()
			mark:select(1)
		end, { desc = "Harpoon: Go to File 1" })
		vim.keymap.set("n", "<leader>h2", function()
			mark:select(2)
		end, { desc = "Harpoon: Go to File 2" })
		vim.keymap.set("n", "<leader>h3", function()
			mark:select(3)
		end, { desc = "Harpoon: Go to File 3" })
		vim.keymap.set("n", "<leader>h4", function()
			mark:select(4)
		end, { desc = "Harpoon: Go to File 4" })
		vim.keymap.set("n", "<leader>h5", function()
			mark:select(5)
		end, { desc = "Harpoon: Go to File 5" })
    vim.keymap.set("n", "<leader>h6", function()
			mark:select(6)
		end, { desc = "Harpoon: Go to File 6" })
    vim.keymap.set("n", "<leader>h7", function()
			mark:select(7)
		end, { desc = "Harpoon: Go to File 7" })
    vim.keymap.set("n", "<leader>h8", function()
			mark:select(8)
		end, { desc = "Harpoon: Go to File 8" })
    vim.keymap.set("n", "<leader>h9", function()
			mark:select(9)
		end, { desc = "Harpoon: Go to File 9" })
    vim.keymap.set("n", "<leader>h0", function()
			mark:select(0)
		end, { desc = "Harpoon: Go to File 10" })
	end,
}
