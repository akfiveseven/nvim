return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  -- keys = {
  --   { "<leader>e", "<cmd>Neotree toggle<cr>", desc = "NeoTree", { silent = true, noremap = true } },
  -- },
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
    "MunifTanjim/nui.nvim",
    -- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
  },
  config = function()
    require('neo-tree').setup({
      -- Customize neo-tree settings here
      filesystem = {
        follow_current_file = {
          enabled = true
        }, -- Follow the file you are working on
        hijack_netrw_behavior = "open_default",  -- Replace netrw
      },
      window = {
        position = "right",  -- Set the tree to appear on the right side
        width = 30,
      },
    })
  end,
}
