local builtin = require('telescope.builtin')
-- get git root if in a git repo
local get_opts = function()
  local function is_git_repo()
    vim.fn.system("git rev-parse --is-inside-work-tree")
    return vim.v.shell_error == 0
  end
  local function get_git_root()
    local dot_git_path = vim.fn.finddir(".git", ".;")
    return vim.fn.fnamemodify(dot_git_path, ":h")
  end
  if is_git_repo() then
    return {
      cwd = get_git_root(),
    }
  else
    return {}
  end
end
local find_files = function()
  local opts = get_opts()
  builtin.find_files(opts)
end
local grep_files = function()
  local opts = get_opts()
  builtin.live_grep(opts)
end
vim.keymap.set('n', '<C-p>', find_files, {desc="Find files"})
vim.keymap.set('n', '<leader>fg', grep_files, {desc="Grep files"})
