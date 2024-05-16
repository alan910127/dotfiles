return {
  "ziontee113/icon-picker.nvim",
  config = function()
    require("icon-picker").setup({ disable_legacy_commands = true })

    ---@param mode string
    ---@param key string
    ---@param func string|fun():nil
    ---@param desc string?
    local map = function(mode, key, func, desc)
      vim.keymap.set(mode, key, func, { noremap = true, silent = true, desc = desc })
    end

    map("n", "<leader><leader>i", "<CMD>IconPickerNormal<CR>", "[I]con Picker")
    map("n", "<leader><leader>y", "<CMD>IconPickerYank<CR>", "Icon Picker [Y]ank Selected")
    map("i", "<C-i>", "<CMD>IconPickerInsert<CR>", "[I]con Picker")
  end,
}
