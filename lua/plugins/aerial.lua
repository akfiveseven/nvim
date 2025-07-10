return {
  "stevearc/aerial.nvim",
  opts = {},
  lazy = false,
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    require("aerial").setup({
      -- optionally use on_attach to set keymaps when aerial has attached to a buffer
      on_attach = function(bufnr)
        -- Jump forwards/backwards with '{' and '}'
        vim.keymap.set("n", "{", "<cmd>AerialPrev<CR>", { buffer = bufnr })
        vim.keymap.set("n", "}", "<cmd>AerialNext<CR>", { buffer = bufnr })
      end,
      layout = {
        -- These control the width of the aerial window.
        -- They can be integers or a float between 0 and 1 (e.g. 0.4 for 40%)
        -- min_width and max_width can be a list of mixed types.
        -- max_width = {40, 0.2} means "the lesser of 40 columns or 20% of total"
        max_width = { 40, 0.2 },
        width = nil,
        min_width = 10,

        -- key-value pairs of window-local options for aerial window (e.g. winhl)
        win_opts = {},

        -- Determines the default direction to open the aerial window. The 'prefer'
        -- options will open the window in the other direction *if* there is a
        -- different buffer in the way of the preferred direction
        -- Enum: prefer_right, prefer_left, right, left, float
        default_direction = "prefer_right",

        -- Determines where the aerial window will be opened
        --   edge   - open aerial at the far right/left of the editor
        --   window - open aerial to the right/left of the current window
        placement = "window",
      },

    })

    -- First make sure you've required both aerial and telescope
    local aerial = require('aerial')
    local telescope = require('telescope')

    -- Load the aerial extension in telescope
    require('telescope').load_extension('aerial')

    -- Now you can create a command to open aerial symbols in telescope
    vim.api.nvim_create_user_command('AerialTelescope', function()
      telescope.extensions.aerial.aerial()
    end, {})

    -- Optional: Add a keybinding
    vim.keymap.set('n', '<leader>ta', ':Telescope aerial<CR>', { desc = "Open Aerial in Telescope", noremap = true, silent = true })

    vim.keymap.set("n", "<leader>ant", "<cmd>AerialNavToggle<CR>", { desc = "Open Aerial Nav", silent = true })
    vim.keymap.set("n", "<leader>at", "<cmd>AerialToggle<CR>", { desc = "Toggle Aerial Sidebar", silent = true })
  end,
}
