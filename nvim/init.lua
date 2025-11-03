-- init.lua

-- Enable Syntax
vim.cmd.syntax("enable")
vim.opt.spell = true
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
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
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
vim.opt.showcmd = true
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
vim.keymap.set("n", "<leader>bn", ":bn<CR>", opts)
vim.keymap.set("n", "<leader>bp", ":bp<CR>", opts)
vim.keymap.set("n", "n", "nzzzv", opts)
vim.keymap.set("n", "N", "Nzzzv", opts)
vim.keymap.set("n", "<C-d>", "<C-d>zz", opts)
vim.keymap.set("n", "<C-u>", "<C-u>zz", opts)
vim.keymap.set("n", "<leader>ls", "<CMD>LspRestart<CR>", opts)
vim.keymap.set({'n','v'}, '<Up>', '<nop>', opts)
vim.keymap.set({'n','v'}, '<Down>', '<nop>', opts)
vim.keymap.set({'n','v'}, '<Left>', '<nop>', opts)
vim.keymap.set({'n','v'}, '<Right>', '<nop>', opts)

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
-- vim.api.nvim_create_autocmd(
--     { "BufRead", "BufNewFile" },
--     {
--         pattern = { "*.txt", "*.md", "README" },
--         callback = function()
--             vim.opt.spell = true
--             vim.opt.spelllang = "en"
--         end,
--     }
-- )

-- Conceal Sensitive data
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
    pattern = { "*.*config", "*.*rc", "*.env*", "*.sh" },
    group = vim.api.nvim_create_augroup("conceal_secrets", { clear = true }),
    callback = function()
        vim.opt_local.conceallevel = 2
        vim.opt_local.concealcursor = "nc"
        vim.api.nvim_set_hl(0, "Conceal", { link = "String" })
        local keywords = "API|AUTH|ENDPOINT|ENTERPRISE|KEY|SECRET|TOKEN|URL"
        -- Fixed the unmatched brackets in the regex patterns
        vim.fn.matchadd("Conceal", [[\v\w*(]] .. keywords .. [[)\w*\="\zs[^"]+\ze"]], 10, -1, { conceal = "" })
        vim.fn.matchadd("Conceal", [[\v\w*(]] .. keywords .. [[)\w*\='\zs[^']+\ze']], 10, -1, { conceal = "" })
        vim.fn.matchadd("Conceal", [[\v\w*(]] .. keywords .. [[)\w*\=\zs[^"'\s]+]], 10, -1, { conceal = "" })
    end,
})

-- Format ColorScheme Popup Menu
vim.api.nvim_create_autocmd("ColorScheme", {
    callback = function()
        vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
        vim.api.nvim_set_hl(0, "Pmenu",       { bg = "none" })
        vim.api.nvim_set_hl(0, "PmenuSel",    { bg = "none" })
        vim.api.nvim_set_hl(0, "FloatBorder", { bg = "none" })
        vim.api.nvim_set_hl(0, "WinSeparator",{ bg = "none" })
    end,
})

-- Alternate to go test file
vim.keymap.set("n", "<leader>gt", function()
    local file = vim.fn.expand("%:p") 
    local alternate
      
        if file:match("_test%.go$:") then
            alternate = file:gsub("_test%.go$", ".go")
        elseif file:match("%.go$") then
            alternate = file:gsub("%.go$", "_test.go")
        else
            print("Not a Go file")
        return
    end
    vim.cmd("edit " .. alternate)
end, { desc = "CUSTOM: Toggle between Go file and test" })

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
