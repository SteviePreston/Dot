-- init.lua

-- Enable Syntax
vim.cmd.syntax("enable")
vim.opt.spell = false
vim.opt.spelllang = "en"

-- File Properties
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undofile = true
vim.opt.scrolloff = 32

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
vim.opt.colorcolumn = "96"

-- Vim Interface
vim.opt.termguicolors = true
vim.opt.updatetime = 128
vim.opt.timeoutlen = 256
vim.opt.signcolumn = "yes"
vim.opt.background = "dark"
vim.opt.clipboard = "unnamedplus"

-- Key Maps
vim.g.mapleader = " "
local opts = { noremap = true, silent = true }

vim.keymap.set("i", "<C-c>", "<Esc>", opts)
vim.keymap.set("n", "n", "nzzzv", opts)
vim.keymap.set("n", "N", "Nzzzv", opts)
vim.keymap.set("n", "<C-d>", "<C-d>zz", opts)
vim.keymap.set("n", "<C-u>", "<C-u>zz", opts)
vim.keymap.set("n", "<leader>ls", "<CMD>LspRestart<CR>", opts)

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

-- Don't auto comment new line
vim.api.nvim_create_autocmd("BufEnter", { command = [[set formatoptions-=cro]] })

-- Go to last loc when opening a buffer
vim.api.nvim_create_autocmd("BufReadPost", {
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local lcount = vim.api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

-- Enable spell checking for certain file types
vim.api.nvim_create_autocmd(
  { "BufRead", "BufNewFile" },
  {
    pattern = { "*.txt", "*.md", "README" },
    callback = function()
      vim.opt.spell = true
      vim.opt.spelllang = "en"
    end,
  }
)

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
require("lazy").setup({ import = "plugins" }, {
  checker = {
    enabled = true,
    notify = false,
  },
  change_detection = {
    enabled = true,
    notify = false,
  },
  ui = {
    border = "rounded"
  },
  performance = {
    rtp = {
      disabled_plugins = {
        "gzip",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
})
