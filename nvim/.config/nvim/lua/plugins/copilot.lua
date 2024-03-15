return {
  "zbirenbaum/copilot-cmp",
  dependencies = {
    "hrsh7th/nvim-cmp",
    {
      "zbirenbaum/copilot.lua",
      event = "InsertEnter",
    },
  },
  config = function()
    require("copilot_cmp").setup()
    require("copilot").setup({
      suggestion = { enabled = false },
      panel = { enabled = false },
    })
  end,
}
