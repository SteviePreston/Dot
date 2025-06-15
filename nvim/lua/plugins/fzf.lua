-- fzf.lua

return {
  "ibhagwan/fzf-lua",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    local actions = require("fzf-lua.actions")
    require("fzf-lua").setup({
      winopts = {
        height = 0.9,
        width = 0.9,
        preview = {
          border = "rounded",
          vertical = "up:60%",
          layout = "vertical",
        },
      },
      fzf_opts = {
        ["--layout"] = "default",   
        ["--info"] = "hidden",
        ["--no-separator"] = "",
      },
      files = {
        prompt = "Files: ",
      },
      grep = {
        prompt = "Grep: ",
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
    vim.keymap.set("n", "<leader>ff", require("fzf-lua").files, { desc = "FzfLua Find Files" })
    vim.keymap.set("n", "<leader>fg", require("fzf-lua").live_grep, { desc = "FzfLua Live Grep" })
    vim.keymap.set("n", "<leader>fb", require("fzf-lua").buffers, { desc = "FzfLua Buffers" })
    vim.keymap.set("n", "<leader>fh", require("fzf-lua").help_tags, { desc = "FzfLua Help Tags" })
    vim.keymap.set("n", "<leader>fl", require("fzf-lua").resume, { desc = "FzfLua Resume" })

    vim.keymap.set("n", "lsd", require("fzf-lua").lsp_definitions, { desc = "FzfLua LSP Definitions" })
    vim.keymap.set("n", "lsr", require("fzf-lua").lsp_references, { desc = "FzfLua LSP References" })
    vim.keymap.set("n", "lsi", require("fzf-lua").lsp_implementations, { desc = "FzfLua LSP Implementations" })

    vim.keymap.set("n", "<leader>lsf", require("fzf-lua").lsp_document_symbols, { desc = "FzfLua LSP File Symbols" })
    vim.keymap.set("n", "<leader>lsg", require("fzf-lua").lsp_workspace_symbols, { desc = "FzfLua LSP Global Symbols" })
    vim.keymap.set("n", "<leader>lsq", require("fzf-lua").quickfix, { desc = "FzfLua Quickfix" })
    vim.keymap.set("n", "<leader>lsd", require("fzf-lua").diagnostics_document, { desc = "FzfLua Diagnostics" })
    vim.keymap.set("n", "<leader>km", require("fzf-lua").keymaps, { desc = "FzfLua Keymaps" })
    vim.keymap.set("n", "<leader>cmd", require("fzf-lua").commands, { desc = "FzfLua Commands" })
  end,
}
