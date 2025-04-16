vim.api.nvim_create_user_command('TabIndentFour', function(opts)
  vim.opt.tabstop = 4
  vim.opt.softtabstop = 4
  vim.opt.shiftwidth = 4
end, { nargs = '?' })

vim.api.nvim_create_user_command('TabIndentTwo', function(opts)
  vim.opt.tabstop = 2
  vim.opt.softtabstop = 2
  vim.opt.shiftwidth = 2
end, { nargs = '?' })

-- Add this to your init.lua or another config file
vim.api.nvim_create_user_command('SnippetsComputerCraft', function()
  vim.cmd('luafile ~/.config/nvim-config-1/lua/snippets/computercraft.lua')
end, {})



-- Create a command to save a register to a file (append mode)
-- :MacroSaveRegister <register>
-- :MacroSaveRegister a
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
