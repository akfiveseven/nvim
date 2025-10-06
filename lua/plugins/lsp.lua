return {
  "neovim/nvim-lspconfig",

  opts = {
    autoformat = true,
  },

  dependencies = {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-cmdline",
    "hrsh7th/nvim-cmp",
    "L3MON4D3/LuaSnip",
    "saadparwaiz1/cmp_luasnip",
    "j-hui/fidget.nvim",
  },

  config = function()
    local cmp = require('cmp')
    local cmp_lsp = require("cmp_nvim_lsp")
    local capabilities = vim.tbl_deep_extend(
      "force",
      {},
      vim.lsp.protocol.make_client_capabilities(),
      cmp_lsp.default_capabilities())

    require("fidget").setup({})
    require("mason").setup()
    require("mason-lspconfig").setup({
      ensure_installed = {
        "lua_ls",
        "pylsp",
        "ast_grep",
        "tailwindcss",
        "ts_ls"
      },
      handlers = {
        function(server_name)
          vim.lsp.enable(server_name)
        end,

        -- zls = function()
        --   local lspconfig = vim.lsp.config
        --   lspconfig.zls.setup({
        --     autostart = true,  -- 🔴 disable autostart
        --     root_dir = lspconfig.util.root_pattern(".git", "build.zig", "zls.json"),
        --     settings = {
        --       zls = {
        --         enable_inlay_hints = true,
        --         enable_snippets = true,
        --         warn_style = true,
        --       },
        --     },
        --   })
        --   vim.g.zig_fmt_parse_errors = 0
        --   vim.g.zig_fmt_autosave = 0
        -- end,

        -- ["lua_ls"] = function()
        --   local lspconfig = vim.lsp.config
        --   lspconfig.lua_ls.setup({
        --     autostart = true,  -- 🔴 disable autostart
        --     capabilities = capabilities,
        --     settings = {
        --       Lua = {
        --         runtime = { version = "Lua 5.1" },
        --         diagnostics = {
        --           globals = { "bit", "vim", "it", "describe", "before_each", "after_each" },
        --         }
        --       }
        --     }
        --   })
        -- end,
      }
    })

    local cmp_select = { behavior = cmp.SelectBehavior.Select }

    local cmp = require("cmp")

    -- Base list of all possible sources
    local base_sources = {
      { name = "nvim_lsp" },
      { name = "luasnip" },
      { name = "buffer" },
      { name = "path" },
    }

    -- Track disabled sources per buffer
    local disabled_by_buf = {}

    -- Helper to build active sources for current buffer
    local function compute_sources(bufnr)
      local disabled = disabled_by_buf[bufnr] or {}
      local out = {}
      for _, s in ipairs(base_sources) do
        if not disabled[s.name] then
          table.insert(out, s)
        end
      end
      return out
    end

    -- Apply updated sources to cmp in this buffer
    local function apply_sources(bufnr)
      bufnr = bufnr or vim.api.nvim_get_current_buf()
      cmp.setup.buffer({ sources = compute_sources(bufnr) })
    end

    -- Define :CmpToggleSource command
    vim.api.nvim_create_user_command("CmpToggleSource", function(opts)
      local bufnr = vim.api.nvim_get_current_buf()
      disabled_by_buf[bufnr] = disabled_by_buf[bufnr] or {}

      local name = opts.args
      local cur = disabled_by_buf[bufnr][name]

      if cur then
        disabled_by_buf[bufnr][name] = nil
        vim.notify("cmp: enabled source '" .. name .. "' for this buffer")
      else
        disabled_by_buf[bufnr][name] = true
        vim.notify("cmp: disabled source '" .. name .. "' for this buffer")
      end

      apply_sources(bufnr)
    end, {
        nargs = 1,
        complete = function()
          return vim.tbl_map(function(s) return s.name end, base_sources)
        end,
      })

    -- Default state: disable nvim_lsp globally
    vim.api.nvim_create_autocmd("BufEnter", {
      callback = function(args)
        local bufnr = args.buf
        disabled_by_buf[bufnr] = disabled_by_buf[bufnr] or {}
        disabled_by_buf[bufnr]["nvim_lsp"] = true -- disable by default
        apply_sources(bufnr)
      end,
    })

    -- CMP setup
    cmp.setup({
      snippet = {
        expand = function(args)
          require("luasnip").lsp_expand(args.body)
        end,
      },
      mapping = cmp.mapping.preset.insert({
        ["<C-p>"] = cmp.mapping.select_prev_item(),
        ["<C-n>"] = cmp.mapping.select_next_item(),
        ["<CR>"] = cmp.mapping.confirm({ select = true }),
        ["<C-Space>"] = cmp.mapping.complete(),
      }),
      sources = {
        { name = "luasnip" }, -- enabled by default
        -- nvim_lsp intentionally not listed here (disabled by default)
      },
    })

    -- Optional: quick keybind to toggle interactively
    vim.keymap.set("n", "<leader>ct", function()
      vim.cmd("CmpToggleSource " .. vim.fn.input("cmp source: "))
    end, { desc = "Toggle nvim-cmp source in current buffer" })

    -- vim.g.cmp_enabled = true
    -- cmp.setup({ enabled = function() return vim.g.cmp_enabled end })
    -- vim.api.nvim_create_user_command('CmpToggle', function()
    --   vim.g.cmp_enabled = not vim.g.cmp_enabled
    --   vim.notify('cmp: ' .. (vim.g.cmp_enabled and 'enabled' or 'disabled'))
    -- end, {})

    vim.diagnostic.config({
      -- update_in_insert = true,
      float = {
        focusable = false,
        style = "minimal",
        border = "rounded",
        source = "always",
        header = "",
        prefix = "",
      },
    })
  end
}
