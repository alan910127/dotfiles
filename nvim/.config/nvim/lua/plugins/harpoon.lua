return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  config = function()
    local harpoon = require("harpoon")
    harpoon:setup({
      settings = {
        save_on_toggle = true,
      },
    })

    ---@param key string
    ---@param cmd fun():nil
    ---@param desc string
    local map = function(key, cmd, desc)
      vim.keymap.set("n", key, cmd, { desc = "Harpoon: " .. desc })
    end

    map("<leader>a", function()
      harpoon:list():add()
    end, "[A]dd")
    map("<C-e>", function()
      harpoon.ui:toggle_quick_menu(harpoon:list())
    end, "Quick [E]dit")

    map("<C-P>", function()
      harpoon:list():prev()
    end, "[P]revious Buffer")
    map("<C-N>", function()
      harpoon:list():next()
    end, "[N]ext Buffer")
  end,
}
