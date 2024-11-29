return {
  "nvim-telescope/telescope-project.nvim",
  init = function()
    require("telescope").load_extension("project")
    vim.keymap.set("n", "<leader>p", "<cmd>Telescope project<cr>", { noremap = true, silent = true })
  end,
}
