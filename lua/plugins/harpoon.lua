return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  dependencies = { "nvim-lua/plenary.nvim" },
  lazy = false,
  config = function()
    local harpoon = require("harpoon")
    harpoon:setup({
      settings = {
        save_on_toggle = true,
        --sync_on_ui_close = true,
        key = function()
          return vim.loop.cwd()
        end,
      },
    })

    -- basic telescope configuration
    local conf = require("telescope.config").values
    local function toggle_telescope(harpoon_files)
      local file_paths = {}
      for _, item in ipairs(harpoon_files.items) do
        table.insert(file_paths, item.value)
      end

      require("telescope.pickers")
        .new({}, {
          prompt_title = "Harpoon",
          finder = require("telescope.finders").new_table({
            results = file_paths,
          }),
          previewer = conf.file_previewer({}),
          sorter = conf.generic_sorter({}),
        })
        :find()
    end

    -- vim.keymap.set("n", "<leader>h", function()
      -- harpoon.ui:toggle_quick_menu(harpoon:list())
    -- end)
    
    vim.keymap.set("n", "<C-e>", function()
        harpoon.ui:toggle_quick_menu(harpoon:list())
    end)

    -- vim.keymap.set("n", "<leader>h", function()
    --     local files = harpoon:list():display()
    --     local names = {}
    --     for _, path in ipairs(files) do
            -- This pattern matches the text after the last slash (either / or \).
    --         local filename = path:match("([^\\/]+)$") or path
    --         table.insert(names, filename)
    --     end
    --     print(vim.inspect(names))
    -- end)

    vim.keymap.set("n", "<leader>h", function()
        local files = harpoon:list():display()
        local names = {}
        for i, path in ipairs(files) do
            -- This pattern matches the text after the last slash (either / or \).
            local filename = path:match("([^\\/]+)$") or path
            table.insert(names, i .. " " .. filename)
        end
        local input = vim.inspect(names)
        local output = input:gsub('[{}"]', '')
        local new = output:gsub(",", " ")
        print(new)
    end)


    -- vim.keymap.set("n", "<leader>h", function()
    --     local files = harpoon:list():display()
    --     local names = {}
    --     for i, path in ipairs(files) do
    --         -- This pattern matches the text after the last slash (either / or \)
    --         -- and removes surrounding double quotes if present.
    --         local filename = path:match('["]?([^"\\/]+)["]?$') or path
    --         table.insert(names, "(" i .. ") " .. filename)
    --     end
    --     print(vim.inspect(names))
    -- end)




    vim.keymap.set("n", "<leader>c", function()
        harpoon:list():clear()
    end, { desc = "Clear Harpoon Marks" })



    -- vim.keymap.set("n", "<leader>h", function()
      -- toggle_telescope(harpoon:list())
    -- end, { desc = "Open harpoon window" })

    -- local harpoon = require("harpoon")

    -- REQUIRED
    -- harpoon:setup()
    -- OPTIONAL: Set up keymaps
    -- vim.keymap.set("n", "<leader>A", function()
    --     harpoon:list():add()
    -- end)
    vim.keymap.set("n", "<leader>a", function()
            harpoon:list():prepend()
    end)

    vim.keymap.set("n", "<leader>A", function()
            harpoon:list():add()
    end)

    -- vim.keymap.set("n", "<C-e>", function()
    -- harpoon.ui:toggle_quick_menu(harpoon:list())
    -- end)

    vim.keymap.set("n", "<leader>1", function()
      harpoon:list():select(1)
    end)

    vim.keymap.set("n", "<leader>2", function()
      harpoon:list():select(2)
    end)
    --
    vim.keymap.set("n", "<leader>3", function()
      harpoon:list():select(3)
    end)

    vim.keymap.set("n", "<leader>4", function()
      harpoon:list():select(4)
    end)

    vim.keymap.set("n", "<leader>5", function()
      harpoon:list():select(5)
    end)

    vim.keymap.set("n", "<leader>6", function()
      harpoon:list():select(6)
    end)
    --
    vim.keymap.set("n", "<leader>7", function()
      harpoon:list():select(7)
    end)

    vim.keymap.set("n", "<leader>8", function()
      harpoon:list():select(8)
    end)

    vim.keymap.set("n", "<leader>9", function()
      harpoon:list():select(9)
    end)

    vim.keymap.set("n", "<leader>0", function()
      harpoon:list():select(10)
    end)

    -- vim.keymap.set("n", "<C-n>", function()
    --   harpoon:list():select(1)
    -- end)

    -- Toggle previous & next buffers stored within Harpoon list
    -- vim.keymap.set("n", "<C-p>", function()
    --   harpoon:list():prev()
    -- end)
    -- vim.keymap.set("n", "<C-n>", function()
    --   harpoon:list():next()
    -- end)
  end,
}
