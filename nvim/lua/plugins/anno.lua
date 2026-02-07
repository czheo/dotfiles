return {
  {
    dir = "~/dev/anno.nvim",
    name = "anno",
    dev = true,
    cmd = { "AnnoAdd", "AnnoYank", "AnnoRemoveAll", "AnnoRemove", "AnnoToggle", "AnnoLoad", "AnnoSave" },
    keys = {
      { "<leader>a",  "",                       desc = "+annotations" },
      { "<leader>aa", "<cmd>AnnoAdd<cr>",       desc = "Add annotation" },
      { "<leader>a",  ":AnnoAdd<cr>",           desc = "Add range annotation",  mode = "v" },
      { "<leader>aj", "<cmd>AnnoNext<cr>",      desc = "Next annotation" },
      { "<leader>ak", "<cmd>AnnoPrev<cr>",      desc = "Previous annotation" },
      { "<leader>ad", "<cmd>AnnoRemove<cr>",    desc = "Delete annotation" },
      { "<leader>ay", "<cmd>AnnoYank<cr>",      desc = "Yank annotations" },
      { "<leader>ap", "<cmd>AnnoYank<cr>p",     desc = "Yank&Paste annotations" },
      { "<leader>aD", "<cmd>AnnoRemoveAll<cr>", desc = "Delete all annotations" },
      { "<leader>at", "<cmd>AnnoToggle<cr>",    desc = "Show/hide annotations" },
      { "<leader>af", "<cmd>AnnoFiles<cr>",     desc = "List annotation files" },
    },
  },
}
