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

        -- vim.api.nvim_create_user_command('BufferSwitch', function()
        --     telescope.buffers({
        --         attach_mappings = function(prompt_bufnr, map)
        --             -- Override the default enter action
        --             actions.select_default:replace(function()
        --                 local selection = action_state.get_selected_entry()
        --                 actions.close(prompt_bufnr)
        --                 -- Get the full path of the selected buffer
        --                 local filepath = vim.api.nvim_buf_get_name(selection.bufnr)
        --                 -- Jump to the window containing this buffer
        --                 vim.cmd(string.format([[call win_gotoid(win_findbuf(bufnr('%s'))[0])]], filepath))
        --             end)
        --             return true
        --         end,
        --     })
        -- end, {})

        vim.api.nvim_create_user_command('BufferSwitch', function()
            telescope.buffers({
                attach_mappings = function(prompt_bufnr, map)
                    -- Override the default enter action
                    actions.select_default:replace(function()
                        local selection = action_state.get_selected_entry()
                        actions.close(prompt_bufnr)

                        -- Check if the buffer exists and has windows
                        local windows = vim.fn.win_findbuf(selection.bufnr)

                        if windows and #windows > 0 then
                            -- Jump to the first window containing this buffer
                            vim.fn.win_gotoid(windows[1])
                        else
                            -- If no window contains the buffer, just switch to it
                            vim.cmd(string.format("buffer %d", selection.bufnr))
                        end
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

        -- Function to rename current tab
        vim.api.nvim_create_user_command('TabRename', function(opts)
            local tabnr = vim.fn.tabpagenr()
            if opts.args ~= '' then
                -- Create tab dictionary if it doesn't exist
                if vim.t[tabnr] == nil then
                    vim.t[tabnr] = {}
                end
                -- Store the custom name
                vim.t[tabnr].custom_name = opts.args
                print("Set tab " .. tabnr .. " name to: " .. opts.args)
            else
                -- If no argument provided, remove custom name
                if vim.t[tabnr] then
                    vim.t[tabnr].custom_name = nil
                end
                print("Removed custom name for tab " .. tabnr)
            end
            -- Force tabline refresh
            vim.cmd('redrawtabline')
        end, { nargs = '?' })

        -- Modified tabline function to use custom names
        function _G.custom_tabline()
            local line = ''
            for i = 1, vim.fn.tabpagenr('$') do
                -- Select highlight group
                line = line .. '%' .. (i == vim.fn.tabpagenr() and '#TabLineSel#' or '#TabLine#')
                -- Add tab number
                line = line .. ' ' .. i .. ' '

                -- Check for custom name first
                local custom_name = vim.t[i] and vim.t[i].custom_name
                if custom_name then
                    line = line .. custom_name .. ' '
                else
                    -- Use default name logic
                    local bufnr = vim.fn.tabpagebuflist(i)[vim.fn.tabpagewinnr(i)]
                    local fname = vim.fn.bufname(bufnr)
                    local name = fname ~= '' and vim.fn.fnamemodify(fname, ':t') or '[No Name]'
                    line = line .. name .. ' '
                end
            end
            -- Fill with TabLineFill and reset tab page nr
            line = line .. '%#TabLineFill#%T'
            return line
        end

        -- Make sure to set the tabline
        vim.opt.tabline = '%!v:lua.custom_tabline()'


        vim.keymap.set('n', '<leader><leader>', ':BufferSwitch<CR>', { noremap = true, silent = true })
        vim.keymap.set('n', '<leader>fv', ':VerticalSplitFiles<CR>', { noremap = true, silent = true })
        vim.keymap.set('n', '<leader>fh', ':HorizontalSplitFiles<CR>', { noremap = true, silent = true })

        vim.keymap.set('n', '<leader>to', ':NewTabFiles<CR>', { noremap = true, silent = true })
        vim.keymap.set('n', '<leader>tr', ':TabRename ', { noremap = true })


    end

}

