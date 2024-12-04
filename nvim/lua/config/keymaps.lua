-- better up/down
vim.keymap.set({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { desc = "Down", expr = true, silent = true })
vim.keymap.set({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { desc = "Up", expr = true, silent = true })

-- move lines
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move Down", silent = true })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move Up", silent = true })

-- clear search highlight with <Esc>
vim.keymap.set("n", "<Esc>", vim.cmd.nohlsearch, { silent = true })

-- quickfix and diagnostics
vim.keymap.set("n", "<leader>xl", vim.cmd.lopen, { desc = "Location List" })
vim.keymap.set("n", "<leader>xq", vim.cmd.copen, { desc = "Quickfix List" })

vim.keymap.set("n", "]q", vim.cmd.cnext, { desc = "Next Quickfix" })
vim.keymap.set("n", "[q", vim.cmd.cprev, { desc = "Previous Quickfix" })

local function diagnostic_goto(loc, severity)
  local loc_to_go_fn = {
    next = vim.diagnostic.goto_next,
    prev = vim.diagnostic.goto_prev,
  }
  local go = loc_to_go_fn[loc] or function(...) end
  severity = severity and vim.diagnostic[severity] or nil
  return function()
    go({ severity = severity })
  end
end

vim.keymap.set("n", "]d", diagnostic_goto("next"), { desc = "Next Diagnostic" })
vim.keymap.set("n", "[d", diagnostic_goto("prev"), { desc = "Previous Diagnostic" })
vim.keymap.set("n", "]e", diagnostic_goto("next", "ERROR"), { desc = "Next Error" })
vim.keymap.set("n", "[e", diagnostic_goto("prev", "ERROR"), { desc = "Previous Error" })
vim.keymap.set("n", "]w", diagnostic_goto("next", "WARN"), { desc = "Next Warning" })
vim.keymap.set("n", "[w", diagnostic_goto("prev", "WARN"), { desc = "Previous Warning" })
