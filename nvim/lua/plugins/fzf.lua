-- fzf.lua

return {
  "ibhagwan/fzf-lua",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    local actions = require("fzf-lua.actions")
    require("fzf-lua").setup({
      winopts = { 
        height = 0.9, 
        width = 0.9 
      },
      fzf_opts = {
        ["--layout"] = "default",   
        ["--info"] = "hidden",
        ["--no-separator"] = "",
      },
      files = {
        prompt = "Find Files: ",
        winopts = {
          preview = {
            border = "rounded",
            vertical = "up:80%",
            layout = "vertical",
          },
        },
      },
      grep = {
        prompt = "Rip Grep: ",
        winopts = {
          preview = {
            border = "rounded",
            vertical = "up:80%",
            layout = "vertical",
          },
        },
      },
      lsp = {
        prompt    = "LSP References: ",
        winopts = {
          preview = {
            border = "rounded",
            vertical = "up:60%",
            layout = "vertical",
          },
        },
        cwd_only          = false,
        async_or_timeout  = 5000,
        file_icons        = true,
        git_icons         = false,
        includeDeclaration = true,
      },
      diagnostics = {
        prompt = "Diagnostics: ",
        winopts = {
          preview = {
            border = "rounded",
            vertical = "up:60%",
            layout = "vertical",
          },
        },
        cwd_only          = false,
        file_icons        = false,
        git_icons         = false,
        color_headings    = true,
        icon_padding      = "",
        multiline         = 3,
      },
      keymaps = {
        prompt = "Keymaps: ",
        winopts = { 
          preview = { 
            hidden = "hidden",
          } 
        },
        show_desc = true,
        show_details = false,
      },
      actions = {
        files = {
          ["default"] = actions.file_edit,
        },
      },
      number            = true,
      relativenumber    = true,
    })

    -- Keybindings
    vim.keymap.set("n", "<leader>ff", require("fzf-lua").files, { desc = "FZF: Find Files" })
    vim.keymap.set("n", "<leader>fg", require("fzf-lua").live_grep, { desc = "FZF: Live Grep" })
    vim.keymap.set("n", "<leader>fb", require("fzf-lua").buffers, { desc = "FZF: Buffers" })
    vim.keymap.set("n", "<leader>fh", require("fzf-lua").help_tags, { desc = "FZF: Help Tags" })
    vim.keymap.set("n", "<leader>fl", require("fzf-lua").resume, { desc = "FZF: Resume" })

    vim.keymap.set("n", "lsd", require("fzf-lua").lsp_definitions, { desc = "LSP: Definitions" })
    vim.keymap.set("n", "lsr", require("fzf-lua").lsp_references, { desc = "LSP: References" })
    vim.keymap.set("n", "lsi", require("fzf-lua").lsp_implementations, { desc = "LSP: Implementations" })
    vim.keymap.set("n", "<leader>lsf", require("fzf-lua").lsp_document_symbols, { desc = "LSP: File Symbols" })
    vim.keymap.set("n", "<leader>lsg", require("fzf-lua").lsp_workspace_symbols, { desc = "LSP: Global Symbols" })
    vim.keymap.set("n", "<leader>lsq", require("fzf-lua").quickfix, { desc = "LSP: Quickfix" })
    vim.keymap.set("n", "<leader>lsd", require("fzf-lua").diagnostics_document, { desc = "LSP: Diagnostics" })

    vim.keymap.set("n", "<leader>km", require("fzf-lua").keymaps, { desc = "FZF: Keymaps" })
    vim.keymap.set("n", "<leader>cmd", require("fzf-lua").commands, { desc = "FZF: Commands" })
  end,
}
