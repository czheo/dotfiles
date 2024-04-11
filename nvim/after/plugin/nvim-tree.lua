require("nvim-tree").setup({
  renderer = {
    group_empty = true,
  },
})


vim.keymap.set('n', '<C-n>', '<cmd>NvimTreeToggle<CR>', {desc="toggle tree"})
