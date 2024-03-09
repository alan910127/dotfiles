return {
  "echasnovski/mini.nvim",
  config = function()
    -- Better Around/Inside textobjects
    require("mini.ai").setup({ n_lines = 500 })

    -- Add/delete/replace surroundings
    require("mini.surround").setup()

    -- Simple and easy statusline
    local statusline = require("mini.statusline")
    statusline.setup()

    ---@diagnostic disable-next-line: duplicate-set-field
    statusline.section_location = function()
      -- Disable the section for cursor information because line numbers are
      -- already enabled
      return ""
    end
  end,
}
