--== LuaSnipList
vim.api.nvim_create_user_command('LuaSnipList', function()
  local ls = require("luasnip")

  -- Get snippets for current buffer
  local ft = vim.bo.filetype
  local snippets = ls.get_snippets(ft)

  print("Snippets for " .. ft .. ":")
  for _, snippet in ipairs(snippets) do
      print("  " .. snippet.trigger .. " - " .. (snippet.name or ""))
  end
end, {})

--== Remove blankline whitespace
vim.api.nvim_create_user_command('BlankRemove', function(opts)
  vim.cmd([[:%s/\s\+$//]])
end, { nargs = '?' })

--== TabIndentFour
vim.api.nvim_create_user_command('TabIndentFour', function(opts)
  vim.opt.tabstop = 4
  vim.opt.softtabstop = 4
  vim.opt.shiftwidth = 4
end, { nargs = '?' })

--== NoLineNumbers
vim.api.nvim_create_user_command('NoLineNumbers', function(opts)
  vim.cmd('setlocal nonumber norelativenumber')
end, { nargs = '?' })

--== TabIndentTwo
vim.api.nvim_create_user_command('TabIndentTwo', function(opts)
  vim.opt.tabstop = 2
  vim.opt.softtabstop = 2
  vim.opt.shiftwidth = 2
end, { nargs = '?' })

--== MarksDeleteAll
vim.api.nvim_create_user_command('MarksDeleteAll', function()
  vim.cmd('demarks a-z')
  vim.cmd('demarks A-Z')
  vim.cmd('demarks 0-9')
end, {})

--== MacroSaveRegister <register>
vim.api.nvim_create_user_command(
  'MacroSaveRegister',
  function(opts)
    local register = opts.args
    if register == "" then
      print("Error: No register specified")
      return
    end

    -- Open in append mode ('a' instead of 'w')
    local file = io.open('macro.lua', 'a')
    if file then
      file:write("vim.cmd([[let @")
      file:write(register)
      file:write(" = \'")
      file:write(vim.fn.getreg(register))
      file:write("\'")
      file:write("]])")  -- Added newline for separation
      file:write("\n")  -- Added newline for separation
      file:close()
      print("Register '" .. register .. "' appended to macro.lua")
    else
      print("Error: Could not open file for writing")
    end
  end,
  { nargs = 1, desc = "Append register content to macro.lua" }
)


-- OPEN AND EXECUTE SNIPPETS

-- Function to open a directory in Telescope and execute luafile on selection
function OpenAndExecute(directory)
  local actions = require('telescope.actions')
  local action_state = require('telescope.actions.state')
  
  -- Use the directory passed as an argument, or default to a specific path
  local target_dir = "~/.config/nvim/lua/snippets"
  
  require('telescope.builtin').find_files({
    prompt_title = "Select Lua File to Execute",
    cwd = vim.fn.expand(target_dir),
    attach_mappings = function(prompt_bufnr, map)
      -- Override the default select action
      actions.select_default:replace(function()
        local selection = action_state.get_selected_entry()
        -- Close telescope before executing the file
        actions.close(prompt_bufnr)
        
        -- Get the full path of the selected file
        local file_path = selection.cwd .. "/" .. selection.value
        
        -- Execute the luafile command on the selected file
        vim.cmd('luafile ' .. file_path)
        print("Executed: " .. file_path)
      end)
      return true
    end,
  })
end

--== LoadSnippets
vim.api.nvim_create_user_command('LoadSnippets', function(opts)
  OpenAndExecute(opts.args)
end, {
  nargs = '?',
  desc = 'Open directory in Telescope and execute selected Lua file',
  complete = 'dir'
})

vim.keymap.set("n", "<leader>lsf", ":LoadSnippets<CR>", { desc = "Load Custom Snippets" })

-- Example keymap (optional)
-- vim.api.nvim_set_keymap('n', '<leader>le', 
--   ":LuaExec<CR>", 
--   {noremap = true, silent = true, desc = 'Execute Lua file from directory'})

-- To provide a specific directory
-- vim.api.nvim_set_keymap('n', '<leader>lp', 
--   ":LuaExec ~/projects/lua-scripts<CR>", 
--   {noremap = true, silent = true, desc = 'Execute Lua file from projects'})
