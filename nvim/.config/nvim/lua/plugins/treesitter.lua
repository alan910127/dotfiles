return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufReadPost", "BufWritePost", "BufNewFile", "VeryLazy" },
    cmd = { "TSUpdateSync", "TSUpdate", "TSInstall" },
    lazy = vim.fn.argc(0) == 0 or vim.fn.isdirectory(vim.fn.argv(0, -1)),
    opts_extend = { "ensure_installed" },
    ---@module "nvim-treesitter"
    ---@type TSConfig
    ---@diagnostic disable-next-line: missing-fields
    opts = {
      highlight = { enable = true },
      indent = { enable = true },
      ensure_installed = {
        "lua",
      },
      sync_install = false,
      auto_install = true,
    },
    ---@module "nvim-treesitter"
    ---@param opts TSConfig
    config = function(_, opts)
      require("nvim-treesitter.configs").setup(opts)
    end,
  },

  {
    "windwp/nvim-ts-autotag",
    event = { "BufReadPost", "BufReadPost", "BufNewFile" },
    opts = {},
  },
}
