-- init.lua

-- Enable Syntax
vim.cmd.syntax("enable")
vim.opt.spell = false
vim.opt.spelllang = "en"

-- File Properties
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undofile = true
vim.opt.scrolloff = 16

-- Text Highlighting
vim.opt.hlsearch = true
vim.opt.incsearch = true

-- Tabbing
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.smartindent = true

-- Text Encoding
vim.opt.linebreak = true
vim.opt.wrap = true

-- Numbers
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true
vim.opt.colorcolumn = "100"

-- Vim Interface
vim.opt.termguicolors = true
vim.opt.updatetime = 50
vim.opt.signcolumn = "yes"
vim.opt.background = "dark"
vim.opt.clipboard = "unnamedplus"

-- Key Maps
vim.g.mapleader = " "
vim.keymap.set("i", "<C-c>", "<Esc>")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "<leader>ls", "<CMD>LspRestart<CR>")

-- Format on Save Auto Command
vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("UserLspConfig", {}),
	callback = function(ev)
		vim.api.nvim_create_autocmd("BufWritePre", {
			buffer = ev.buf,
			callback = function()
				vim.lsp.buf.format({ async = false })
			end,
		})
	end,
})

-- Lazy Plugin Manager
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)
require("lazy").setup("plugins", opts)
