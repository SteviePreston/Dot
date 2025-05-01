-- treesitter.lua

return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  config = function()
    require("nvim-treesitter.configs").setup({
      ensure_installed = {
          "go", "python", "lua", "javascript", "typescript",
          "terraform", "hcl", "yaml", "dockerfile", "c", "rust", 
      }, 
      highlight = { enable = true },
    })
  end,
}
