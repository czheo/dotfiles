return {
  "0x00-ketsu/maximizer.nvim",
  vim.api.nvim_set_keymap(
    "n",
    "<leader>wt",
    '<cmd>lua require("maximizer").toggle()<CR>',
    { silent = true, noremap = true, desc = "toggle maximize window" }
  ),
}
