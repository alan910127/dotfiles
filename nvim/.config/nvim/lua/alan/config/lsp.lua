---@type table<string, table>
local M = {}

M.rust = {
  rust_analyzer = {
    settings = {
      ["rust-analyzer"] = {
        checkOnSave = {
          command = "clippy",
        },
      },
    },
  },
}

M.c_cpp = {
  clangd = {
    cmd = { "clangd", "--offset-encoding=utf-16" },
  },
}

M.golang = {
  gopls = {},
}

M.python = {
  basedpyright = {},
  ruff_lsp = {},
}

M.typescript = {
  tsserver = {},
  biome = {},
  prettier = {},
}

M.lua = {
  lua_ls = {
    settings = {
      Lua = {
        runtime = { version = "LuaJIT" },
        workspace = {
          checkThirdParty = false,
          library = {
            "${3rd}/luv/library",
            unpack(vim.api.nvim_get_runtime_file("", true)),
          },
        },
        completion = {
          callSnippet = "Replace",
        },
      },
    },
  },
  stylua = {},
}

M.docker = {
  docker_compose_language_service = {},
  dockerls = {},
}

M.shell = {
  shfmt = {},
}

M.json = {
  jsonls = {},
}

M.yaml = {
  yamlls = {},
}

M.toml = {
  taplo = {},
}

local tbl_merge_all = function()
  local merged = {}
  for _, tbl in pairs(M) do
    merged = vim.tbl_extend("force", merged, tbl)
  end

  return merged
end

return tbl_merge_all()
