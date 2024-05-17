return {
  "NeogitOrg/neogit",
  tag = "v1.0.0",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "sindrets/diffview.nvim",
    "nvim-telescope/telescope.nvim",
  },
  config = function()
    local neogit = require("neogit")
    local telescope = require("telescope.builtin")
    neogit.setup({
      graph_style = "unicode",
    })

    ---@param key string
    ---@param cmd string|fun():nil
    ---@param desc string
    local map = function(key, cmd, desc)
      vim.keymap.set("n", key, cmd, { desc = "Git: " .. desc })
    end

    ---@param key string
    ---@param opt table
    ---@param desc string
    local mapneogit = function(key, opt, desc)
      -- stylua: ignore
      map(key, function() neogit.open(opt) end, desc)
    end

    mapneogit("<leader>gs", {}, "[G]it [S]tatus")
    mapneogit("<leader>gc", { "commit" }, "[G]it [C]ommit")
    mapneogit("<leader>gl", { "pull" }, "[G]it Pu[l]l")
    mapneogit("<leader>gp", { "push" }, "[G]it [P]ush")

    map("<leader>gb", telescope.git_branches, "[G]it [B]ranches")
  end,
}
