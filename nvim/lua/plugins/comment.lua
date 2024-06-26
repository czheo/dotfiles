return {
  "numToStr/Comment.nvim",
  lazy = false,
  init = function()
    require("Comment").setup({
      mappings = {
        -- disable default key bindings
        basic = false,
      },
    })
    local api = require("Comment.api")
    vim.keymap.set("n", "<C-_><C-_>", api.toggle.linewise.current, { silent = true, desc = "toggle comment" })

    local ESC = vim.api.nvim_replace_termcodes("<ESC>", true, false, true)
    vim.keymap.set("x", "<C-_><C-_>", function()
      vim.api.nvim_feedkeys(ESC, "nx", false)
      api.toggle.linewise(vim.fn.visualmode())
    end, { desc = "toggle comment" })
  end,
}
