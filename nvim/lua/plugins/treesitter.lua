-- treesitter.lua

return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  config = function()
    require("nvim-treesitter.configs").setup({
      ensure_installed = {
          "go", "python", "lua", "javascript", "typescript",
          "terraform", "hcl", "yaml", "dockerfile", "json",
          "jinja", "make", "c", "helm","markdown", "rust", 
          "css", "html", "bash", "gomod", "gosum", "proto",
          "vim", "vimdoc", "cpp", "ruby", "java", 
      }, 
      highlight = { enable = true },
    })
  end,
}
