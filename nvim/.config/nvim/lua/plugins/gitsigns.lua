return {
  {
    "lewis6991/gitsigns.nvim",
    opts = {
      attach_to_untracked = true,
      current_line_blame = true,
      ---@param buffer integer
      on_attach = function(buffer)
        ---@param mode string
        ---@param keys string
        ---@param func function
        ---@param desc string
        ---@param opts? table
        local map = function(mode, keys, func, desc, opts)
          opts = vim.tbl_extend("force", { buffer = buffer, desc = "Git: " .. desc }, opts or {})
          vim.keymap.set(mode, keys, func, opts)
        end

        local gitsigns = require("gitsigns")

        map("n", "]c", function()
          if vim.wo.diff then
            return "]c"
          end
          vim.schedule(function()
            gitsigns.next_hunk()
          end)
          return "<Ignore>"
        end, "Next [C]hange", { expr = true })

        map("n", "[c", function()
          if vim.wo.diff then
            return "[c"
          end
          vim.schedule(function()
            gitsigns.prev_hunk()
          end)
          return "<Ignore>"
        end, "Previous [C]hange", { expr = true })

        map("n", "<leader>hs", gitsigns.stage_hunk, "[H]unk [S]tage")
        map("n", "<leader>hr", gitsigns.reset_hunk, "[H]unk [R]eset")
        map("v", "<leader>hs", function()
          gitsigns.stage_hunk({
            vim.fn.line("."),
            vim.fn.line("v"),
          })
        end, "[H]unk [S]tage")
        map("v", "<leader>hr", function()
          gitsigns.reset_hunk({
            vim.fn.line("."),
            vim.fn.line("v"),
          })
        end, "[H]unk [R]eset")
        map("n", "<leader>hS", gitsigns.stage_buffer, "[H]unk [S]tage (Buffer)")
        map("n", "<leader>hu", gitsigns.undo_stage_hunk, "[H]unk [U]ndo")
        map("n", "<leader>hp", gitsigns.preview_hunk, "[H]unk [P]review")
      end,
    },
  },
}
