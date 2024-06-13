local HIDDEN_NAMES = {
  "..",
  ".git",
}

return {
  "stevearc/oil.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    local oil = require("oil")

    oil.setup({
      delete_to_trash = true,
      skip_confirm_for_simple_edits = true,
      view_options = {
        show_hidden = true,
        is_always_hidden = function(name, bufnr)
          return vim.list_contains(HIDDEN_NAMES, name)
        end,
      },
    })

    vim.keymap.set("n", "-", oil.open, { desc = "Open parent directory", silent = true })
    vim.keymap.set("n", "<Space>-", oil.toggle_float)
  end,
}
