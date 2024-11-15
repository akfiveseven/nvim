vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.wrap = false

-- vim.opt.foldmethod = "indent"

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true
vim.cmd [[colorscheme rose-pine]]

vim.opt.scrolloff = 4
vim.opt.signcolumn = "no"
vim.opt.isfname:append("@-@")

vim.opt.fillchars = {eob = " "}

vim.opt.updatetime = 50
--vim.opt.colorcolumn = "80"

-- vim.g.lua_snippets_path = vim.fn.stdpath "config" .. "/lua/lua_snippets"


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

vim.keymap.set('n', '<leader>tr', ':TabRename ', { noremap = true })
