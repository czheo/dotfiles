return {
  "L3MON4D3/LuaSnip",
  keys = function()
    return {
      {
        "<c-l>",
        function()
          require("luasnip").expand()
        end,
        mode = "i",
        silent = true,
        desc = "Expand snippet",
      },
    }
  end,
  config = function()
    require("luasnip.loaders.from_lua").load({
      paths = "~/.dotfiles/nvim/snippets",
    })
  end,
}
