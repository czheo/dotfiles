-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = vim.keymap.set

map("t", "<c-l>", "<nop>")

-- Keymaps to move among splits in insert mode
map("i", "<C-h>", "<C-\\><C-N><C-w>h", { desc = "Move to left split" })
map("i", "<C-j>", "<C-\\><C-N><C-w>j", { desc = "Move to below split" })
map("i", "<C-k>", "<C-\\><C-N><C-w>k", { desc = "Move to above split" })
map("i", "<C-l>", "<C-\\><C-N><C-w>l", { desc = "Move to right split" })
