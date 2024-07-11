return {
  "folke/trouble.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    local trouble = require("trouble")
    trouble.setup()

    ---@param keys string
    ---@param func string|fun():nil
    ---@param desc string
    local map = function(keys, func, desc)
      vim.keymap.set("n", keys, func, { desc = "Trouble: " .. desc })
    end

    map("<leader>tt", function()
      trouble.toggle("diagnostics")
    end, "[T]rouble [T]oggle")

    map("]t", function()
      trouble.next({ jump = true })
    end, "Next Trouble Item")

    map("[t", function()
      trouble.prev({ jump = true })
    end, "Previous Trouble Item")
  end,
}
