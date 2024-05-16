return {
  "stevearc/oil.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    local oil = require("oil")

    oil.setup({
      view_options = {
        show_hidden = true,
      },
    })

    vim.keymap.set("n", "-", oil.open, { desc = "Open parent directory", silent = true })
    vim.keymap.set("n", "<Space>-", oil.toggle_float)
  end,
}
