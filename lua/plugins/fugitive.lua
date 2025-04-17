return {
  'tpope/vim-fugitive',
  cmd = { 'Git', 'G' },  -- Optional: lazy-load on Git commands
  keys = {
    { "<leader>gs", ":Git<CR>", desc = "Git status" }
  }
}
