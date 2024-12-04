return {
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    },
    opts = {
      lsp = {
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
          ["cmp.entry.get_documentation"] = true,
        },
        presets = {
          bottom_search = true,
          command_palette = true,
          long_message_to_split = true,
          inc_rename = false,
          lsp_doc_border = true,
        },
      },
    },
  },

  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = function()
      local devicons = require("nvim-web-devicons")
      local function get_recording()
        local reg = vim.fn.reg_recording()
        if reg == "" then
          return ""
        end
        return "Recording @" .. reg
      end

      return {
        sections = {
          lualine_c = {
            "filename",
            { get_recording, icon = devicons.get_icon("filetype", "cast") },
          },
          -- Remove progress & location
          lualine_y = {},
          lualine_z = {},
        },
      }
    end,
  },
}
