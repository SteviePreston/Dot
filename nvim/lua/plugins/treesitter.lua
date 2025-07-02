-- treesitter.lua

return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  config = function()
    require("nvim-treesitter.configs").setup({
      ensure_installed = {
          "go", "python", "lua", "javascript", "typescript", "ruby", "rust", "c",
          "terraform", "hcl", "yaml", "json", "dockerfile", "html", "toml", "make",
      }, 
      highlight = { enable = true },
    })
  end,
}
