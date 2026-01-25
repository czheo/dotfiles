return {
  "sindrets/diffview.nvim",
  init = function()
    vim.keymap.set("n", "<leader>gvv", "<CMD>DiffviewOpen<CR>", { desc = "Open Diff View" })
    vim.keymap.set("n", "<leader>gvh", "<CMD>DiffviewFileHistory<CR>", { desc = "Open Diff View History" })
    vim.keymap.set("n", "<leader>gvd", "<CMD>DiffviewClose<CR>", { desc = "Close Diff View" })
  end,
}
