local luasnip = require("luasnip")

local snip = luasnip.snippet
local ins = luasnip.insert_node

local fmt = require("luasnip.extras.fmt").fmt

local pymain = [[
def main() -> None:
    {}


if __name__ == "__main__":
    main()
]]

luasnip.add_snippets("python", {
  snip("pymain", fmt(pymain, { ins(0) })),
})
