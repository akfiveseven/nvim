return {
    "nvim-telescope/telescope.nvim",

    tag = "0.1.5",

    dependencies = {
        "nvim-lua/plenary.nvim"
    },

    config = function()
        require('telescope').setup({})

        local builtin = require('telescope.builtin')
        vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
        -- vim.keymap.set('n', '<C-p>', builtin.git_files, {})
        -- vim.keymap.set('n', '<leader>pws', function()
        --     local word = vim.fn.expand("<cword>")
        --     builtin.grep_string({ search = word })
        -- end)
        -- vim.keymap.set('n', '<leader>pWs', function()
        --     local word = vim.fn.expand("<cWORD>")
        --     builtin.grep_string({ search = word })
        -- end)
        vim.keymap.set('n', '<leader>fw', function()
            builtin.grep_string({ search = vim.fn.input("Grep > ") })
        end)
        vim.keymap.set('n', '<leader>fb', ":Telescope buffers<CR>", { silent=true })
        -- vim.keymap.set('n', '<leader>vh', builtin.help_tags, {})


        local telescope = require('telescope.builtin')
        local actions = require('telescope.actions')
        local action_state = require('telescope.actions.state')

        vim.api.nvim_create_user_command('BufferSwitch', function()
            telescope.buffers({
                attach_mappings = function(prompt_bufnr, map)
                    -- Override the default enter action
                    actions.select_default:replace(function()
                        local selection = action_state.get_selected_entry()
                        actions.close(prompt_bufnr)
                        -- Get the full path of the selected buffer
                        local filepath = vim.api.nvim_buf_get_name(selection.bufnr)
                        -- Jump to the window containing this buffer
                        vim.cmd(string.format([[call win_gotoid(win_findbuf(bufnr('%s'))[0])]], filepath))
                    end)
                    return true
                end,
            })
        end, {})


        vim.api.nvim_create_user_command('VerticalSplitFiles', function()
            telescope.find_files({
                attach_mappings = function(prompt_bufnr, map)
                    -- Override the default enter action
                    actions.select_default:replace(function()
                        local selection = action_state.get_selected_entry()
                        actions.close(prompt_bufnr)
                        -- Open the file in a vertical split
                        vim.cmd('vsplit ' .. selection.path)
                    end)
                    return true
                end,
            })
        end, {})

        vim.api.nvim_create_user_command('HorizontalSplitFiles', function()
            telescope.find_files({
                attach_mappings = function(prompt_bufnr, map)
                    -- Override the default enter action
                    actions.select_default:replace(function()
                        local selection = action_state.get_selected_entry()
                        actions.close(prompt_bufnr)
                        -- Open the file in a vertical split
                        vim.cmd('split ' .. selection.path)
                    end)
                    return true
                end,
            })
        end, {})

        vim.api.nvim_create_user_command('NewTabFiles', function()
            telescope.find_files({
                attach_mappings = function(prompt_bufnr, map)
                    -- Override the default enter action
                    actions.select_default:replace(function()
                        local selection = action_state.get_selected_entry()
                        actions.close(prompt_bufnr)
                        -- Open the file in a vertical split
                        vim.cmd('tabnew ' .. selection.path)
                    end)
                    return true
                end,
            })
        end, {})


        vim.keymap.set('n', '<leader>ft', ':BufferSwitch<CR>', { noremap = true, silent = true })
        vim.keymap.set('n', '<leader>vs', ':VerticalSplitFiles<CR>', { noremap = true, silent = true })
        vim.keymap.set('n', '<leader>hs', ':HorizontalSplitFiles<CR>', { noremap = true, silent = true })
        vim.keymap.set('n', '<leader>ot', ':NewTabFiles<CR>', { noremap = true, silent = true })


    end
}

