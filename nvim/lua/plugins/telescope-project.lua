return {
  "nvim-telescope/telescope-project.nvim",
  -- this plugin takes 100ms+ to start which is a little slow so disabled
  enabled = false,
  init = function()
    require("telescope").load_extension("project")
    vim.keymap.set("n", "<leader>p", "<cmd>Telescope project<cr>", { noremap = true, silent = true })
  end,
}
