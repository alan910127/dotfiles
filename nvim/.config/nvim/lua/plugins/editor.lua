local have_make = vim.fn.executable("make") == 1
local have_cmake = vim.fn.executable("cmake") == 1

return {
  {
    "stevearc/oil.nvim",
    lazy = false,
    dependencies = { "nvim-tree/nvim-web-devicons" },
    keys = {
      {
        "-",
        function()
          require("oil").open()
        end,
        desc = "Open parent directory",
      },
      {
        "<leader>-",
        function()
          require("oil").toggle_float()
        end,
        desc = "Open parent directory (float)",
      },
    },
    ---@module "oil"
    ---@type oil.SetupOpts
    opts = {
      default_file_explorer = true,
      delete_to_trash = true,
      skip_confirm_for_simple_edits = true,
      view_options = {
        show_hidden = true,
        is_always_hidden = function(name)
          return vim.list_contains({ "..", ".git" }, name)
        end,
      },
    },
  },

  {
    "MagicDuck/grug-far.nvim",
    opts = { headerMaxWidth = 80 },
    cmd = "GrugFar",
    keys = {
      {
        "<leader>sr",
        function()
          local ext = vim.bo.buftype == "" and vim.fn.expand("%:e")
          require("grug-far").open({
            transient = true,
            prefills = {
              filesFilter = ext and ext ~= "" and "*." .. ext or nil,
            },
          })
        end,
        mode = { "n", "v" },
        desc = "Search and Replace",
      },
    },
  },

  {
    "folke/flash.nvim",
    event = "VeryLazy",
    ---@type Flash.Config
    opts = {},
    -- stylua: ignore
    keys = {
      { "s", function() require("flash").jump() end, mode = { "n", "x", "o" }, desc = "Flash", },
      { "S", function() require("flash").treesitter() end, mode = { "n", "x", "o" }, desc = "Flash Treesitter", },
    },
  },

  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts_extend = { "spec" },
    opts = {
      defaults = {},
      spec = {
        {
          mode = { "n", "v" },
          { "<leader>c", group = "Code" },
          { "<leader>d", group = "Document" },
          { "<leader>r", group = "Rename" },
          { "<leader>s", group = "Search" },
          { "<leader>w", group = "Workspace" },
          { "[", group = "Previous" },
          { "]", group = "Next" },
          { "g", group = "Goto" },
        },
      },
    },
  },

  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPost", "BufWritePost", "BufNewFile" },
    opts = {
      attach_to_untracked = true,
      current_line_blame = true,
      on_attach = function(buffer)
        ---@param mode string|string[]
        ---@param keys string
        ---@param func string|fun():nil
        ---@param desc string
        local function map(mode, keys, func, desc)
          vim.keymap.set(mode, keys, func, { buffer = buffer, desc = "Git: " .. desc })
        end

        local gs = require("gitsigns")

        map("n", "]h", function()
          if vim.wo.diff then
            vim.cmd.normal({ "]c", bang = true })
          else
            gs.nav_hunk("next")
          end
        end, "Next Hunk")
        map("n", "[h", function()
          if vim.wo.diff then
            vim.cmd.normal({ "[c", bang = true })
          else
            gs.nav_hunk("prev")
          end
        end, "Previous Hunk")
        -- stylua: ignore start
        map("n", "]H", function() gs.nav_hunk("last") end, "Last Hunk")
        map("n", "[H", function() gs.nav_hunk("first") end, "First Hunk")
        map("n", "<leader>hs", gs.stage_hunk, "Stage Hunk")
        map("n", "<leader>hr", gs.reset_hunk, "Reset Hunk")
        map("v", "<leader>hs", function() gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") }) end, "Stage Visual Area")
        map("v", "<leader>hr", function() gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") }) end, "Stage Visual Area")
        map("n", "<leader>hS", gs.stage_buffer, "Stage Buffer")
        map("n", "<leader>hu", gs.undo_stage_hunk, "Undo Stage Hunk")
        map("n", "<leader>hR", gs.reset_buffer, "Reset Buffer")
        map("n", "<leader>hp", gs.preview_hunk, "Preview Hunk Diff")
      end,
    },
  },

  {
    "NeogitOrg/neogit",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "sindrets/diffview.nvim",
      "nvim-telescope/telescope.nvim",
    },
    keys = function()
      local neogit = require("neogit")
      return {
        { "<leader>gs", neogit.open, desc = "Git Status" },
      }
    end,
    opts = {},
  },

  {
    "folke/trouble.nvim",
    cmd = { "Trouble" },
    opts = {
      modes = {
        lsp = {
          win = { position = "right" },
        },
      },
    },
    keys = {
      { "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", desc = "Trouble: Diagnostics" },
      { "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Trouble: Buffer Diagnostics" },
      { "<leader>cs", "<cmd>Trouble symbols toggle<cr>", desc = "Trouble: Symbols" },
      { "<leader>cS", "<cmd>Trouble lsp toggle<cr>", desc = "Trouble: LSP references/definitions/..." },
      { "<leader>xL", "<cmd>Trouble loclist toggle<cr>", desc = "Trouble: Location List" },
      { "<leader>xQ", "<cmd>Trouble qflist toggle<cr>", desc = "Trouble: Quickfix List" },
      {
        "[q",
        function()
          if require("trouble").is_open() then
            require("trouble").prev({ skip_groups = true, jump = true })
          else
            local ok, err = pcall(vim.cmd.cprev)
            if not ok then
              vim.notify(err, vim.log.levels.ERROR)
            end
          end
        end,
        desc = "Previous Trouble/Quickfix Item",
      },
      {
        "]q",
        function()
          if require("trouble").is_open() then
            require("trouble").next({ skip_groups = true, jump = true })
          else
            local ok, err = pcall(vim.cmd.cnext)
            if not ok then
              vim.notify(err, vim.log.levels.ERROR)
            end
          end
        end,
        desc = "Next Trouble/Quickfix Item",
      },
    },
  },

  {
    "folke/todo-comments.nvim",
    cmd = { "TodoTrouble", "TodoTelescope" },
    event = { "BufReadPost", "BufWritePost", "BufNewFile" },
    opts = {},
    -- stylua: ignore
    keys = {
      { "]t", function() require("todo-comments").jump_next() end, desc = "Next Todo Comment" },
      { "[t", function() require("todo-comments").jump_prev() end, desc = "Previous Todo Comment" },
      { "<leader>xt", "<cmd>Trouble todo toggle<cr>", desc = "Trouble: Todo" },
      { "<leader>xT", "<cmd>Trouble todo toggle filter = {tag = {TODO,FIX,FIXME}}<cr>", desc = "Trouble: Todo/Fix/Fixme" },
      { "<leader>st", "<cmd>TodoTelescope<cr>", desc = "Search Todo" },
      { "<leader>sT", "<cmd>TodoTelescope keywords=TODO,FIX,FIXME<cr>", desc = "Search Todo/Fix/Fixme" },
    },
  },

  {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    version = false,
    dependencies = {
      "nvim-lua/plenary.nvim",
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = have_make and "make" or "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release",
        enabled = have_make or have_cmake,
        config = function()
          pcall(require("telescope").load_extension, "fzf")
        end,
      },
      {
        "nvim-telescope/telescope-ui-select.nvim",
        config = function()
          pcall(require("telescope").load_extension, "ui-select")
        end,
      },
      "nvim-tree/nvim-web-devicons",
    },
    keys = function()
      local telescope = require("telescope.builtin")

      return {
        { "<leader>sh", telescope.help_tags, desc = "Search Help" },
        { "<leader>sk", telescope.keymaps, desc = "Search Keymaps" },
        { "<leader>sf", telescope.find_files, desc = "Search Files" },
        { "<leader>ss", telescope.builtin, desc = "Search Select Telescope" },
        { "<leader>sw", telescope.grep_string, desc = "Search Current Word" },
        { "<leader>sg", telescope.live_grep, desc = "Search by Grep" },
        { "<leader>sd", telescope.diagnostics, desc = "Search Diagnostics" },
        { "<leader>sr", telescope.resume, desc = "Search Resume" },
        { "<leader>s.", telescope.oldfiles, desc = "Search Recent Files" },
        { "<leader><space>", telescope.buffers, desc = "Search Existing Buffers" },
        {
          "<leader>/",
          function()
            telescope.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
              winblend = 10,
              previewer = false,
            }))
          end,
          desc = "Fuzzily Search in Current Buffer",
        },
        {
          "<leader>s/",
          function()
            telescope.live_grep({
              grep_open_files = true,
              prompt_title = "Live Grep in Open Files",
            })
          end,
          desc = "Live Grep in Open Files",
        },
        {
          "<leader>sn",
          function()
            telescope.find_files({ cwd = vim.fn.stdpath("config") })
          end,
          desc = "Search Neovim Files",
        },
      }
    end,
    opts = function()
      return {
        defaults = {
          file_ignore_patterns = { "%.git/" },
        },
        extensions = {
          ["ui-select"] = {
            require("telescope.themes").get_dropdown(),
          },
        },
        pickers = {
          find_files = {
            hidden = true,
          },
        },
      }
    end,
  },

  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    keys = function()
      local harpoon = require("harpoon")
      local keys = {
        {
          "<leader>a",
          function()
            harpoon:list():add()
          end,
          desc = "Add to Harpoon List",
        },
        {
          "<C-e>",
          function()
            harpoon.ui:toggle_quick_menu(harpoon:list())
          end,
          desc = "Add to Harpoon List",
        },
        {
          "<C-p>",
          function()
            harpoon:list():prev()
          end,
          desc = "Harpoon to Previous",
        },
        {
          "<C-n>",
          function()
            harpoon:list():next()
          end,
          desc = "Harpoon to Next",
        },
      }

      for i = 1, 5 do
        table.insert(keys, {
          "h" .. i,
          function()
            harpoon:list():select(i)
          end,
          desc = "Harpoon to Buffer " .. i,
        })
      end

      return keys
    end,
    config = function(_, opts)
      require("harpoon"):setup(opts)
    end,
  },

  { "ThePrimeagen/vim-be-good" },
}
