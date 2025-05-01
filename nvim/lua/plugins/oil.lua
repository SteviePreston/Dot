--Oil.lua

return {
  {
    "stevearc/oil.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      _G.CustomOilBar = function()
        local path = vim.fn.expand("%"):gsub("oil://", "")
        return "  " .. vim.fn.fnamemodify(path, ":.")
      end

      require("oil").setup {
        columns = { "icon" },
        keymaps = {
          ["<M-h>"] = "actions.select_split",
        },
        win_options = {
          winbar = "%{v:lua.CustomOilBar()}",
        },
        view_options = {
          show_hidden = true,
          is_always_hidden = function(name, _)
            local skip = { "dev-tools.locks", "dune.lock", "_build" }
            return vim.tbl_contains(skip, name)
          end,
        },
      }

      vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
      vim.keymap.set("n", "<leader>-", require("oil").toggle_float)
    end,
  },
}
