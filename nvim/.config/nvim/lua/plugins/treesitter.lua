return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  opts = function()
    require("nvim-treesitter.configs").setup({
      ensure_installed = { "lua", "rust", "markdown", "python", "go" },
      -- Auto install languages that are not installed
      auto_install = true,
      highlight = { enable = true },
      indent = { enable = true },
    })
  end,
}
