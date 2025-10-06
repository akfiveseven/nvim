-- snippet-stash.nvim
-- A Neovim plugin for storing and retrieving filetype-specific code blocks

local M = {}
local api = vim.api
local fn = vim.fn

-- Configuration
M.config = {
  storage_path = fn.stdpath('data') .. '/snippet-stash.json',
}

-- Storage structure: { [filetype] = { {name, content}, ... } }
local snippets = {}

-- Load snippets from disk
local function load_snippets()
  local file = io.open(M.config.storage_path, 'r')
  if file then
    local content = file:read('*all')
    file:close()
    local success, data = pcall(vim.json.decode, content)
    if success and data then
      snippets = data
    end
  end
end

-- Save snippets to disk
local function save_snippets()
  local file = io.open(M.config.storage_path, 'w')
  if file then
    file:write(vim.json.encode(snippets))
    file:close()
  end
end

-- Get current filetype
local function get_filetype()
  local ft = vim.bo.filetype
  if ft == '' then
    ft = 'text'
  end
  return ft
end

-- Save a code block
function M.save_snippet(opts)
  local ft = get_filetype()
  
  -- Get visual selection or current line
  local start_line, end_line
  
  -- Check if called with range (from visual mode)
  if opts and opts.range > 0 then
    start_line = opts.line1
    end_line = opts.line2
  else
    -- Use marks for visual selection
    start_line = fn.line("'<")
    end_line = fn.line("'>")
    
    -- If marks aren't set, use current line
    if start_line == 0 or end_line == 0 then
      start_line = fn.line('.')
      end_line = fn.line('.')
    end
  end
  
  local lines = api.nvim_buf_get_lines(0, start_line - 1, end_line, false)
  local content = table.concat(lines, '\n')
  
  if content == '' then
    print('No content to save')
    return
  end
  
  -- Prompt for snippet name
  vim.ui.input({ prompt = 'Snippet name: ' }, function(name)
    if not name or name == '' then
      print('Save cancelled')
      return
    end
    
    -- Initialize filetype table if needed
    if not snippets[ft] then
      snippets[ft] = {}
    end
    
    -- Add snippet
    table.insert(snippets[ft], {
      name = name,
      content = content,
    })
    
    save_snippets()
    print('Snippet "' .. name .. '" saved for filetype: ' .. ft)
  end)
end

-- Show snippet menu and insert selected snippet
function M.show_snippets()
  local ft = get_filetype()
  
  if not snippets[ft] or #snippets[ft] == 0 then
    print('No snippets saved for filetype: ' .. ft)
    return
  end
  
  -- Create menu items
  local items = {}
  for i, snippet in ipairs(snippets[ft]) do
    table.insert(items, i .. '. ' .. snippet.name)
  end
  
  vim.ui.select(items, {
    prompt = 'Select snippet (' .. ft .. '):',
    format_item = function(item)
      return item
    end,
  }, function(choice, idx)
    if not idx then
      return
    end
    
    M.insert_snippet(ft, idx)
  end)
end

-- Insert a snippet at cursor position
function M.insert_snippet(ft, idx)
  if not snippets[ft] or not snippets[ft][idx] then
    print('Snippet not found')
    return
  end
  
  local snippet = snippets[ft][idx]
  local lines = vim.split(snippet.content, '\n')
  
  -- Get cursor position
  local cursor = api.nvim_win_get_cursor(0)
  local row = cursor[1]
  
  -- Insert lines at cursor
  api.nvim_buf_set_lines(0, row, row, false, lines)
  
  print('Inserted snippet: ' .. snippet.name)
end

-- Delete a snippet
function M.delete_snippet()
  local ft = get_filetype()
  
  if not snippets[ft] or #snippets[ft] == 0 then
    print('No snippets saved for filetype: ' .. ft)
    return
  end
  
  local items = {}
  for i, snippet in ipairs(snippets[ft]) do
    table.insert(items, i .. '. ' .. snippet.name)
  end
  
  vim.ui.select(items, {
    prompt = 'Delete snippet (' .. ft .. '):',
  }, function(choice, idx)
    if not idx then
      return
    end
    
    local name = snippets[ft][idx].name
    table.remove(snippets[ft], idx)
    save_snippets()
    print('Deleted snippet: ' .. name)
  end)
end

-- List all snippets for current filetype
function M.list_snippets()
  local ft = get_filetype()
  
  if not snippets[ft] or #snippets[ft] == 0 then
    print('No snippets saved for filetype: ' .. ft)
    return
  end
  
  print('Snippets for ' .. ft .. ':')
  for i, snippet in ipairs(snippets[ft]) do
    print('  ' .. i .. '. ' .. snippet.name)
  end
end

-- Setup function
function M.setup(opts)
  opts = opts or {}
  M.config = vim.tbl_deep_extend('force', M.config, opts)
  
  -- Load existing snippets
  load_snippets()
  
  -- Create commands
  api.nvim_create_user_command('SnippetSave', function()
    M.save_snippet()
  end, { range = true })
  
  api.nvim_create_user_command('SnippetShow', function()
    M.show_snippets()
  end, {})
  
  api.nvim_create_user_command('SnippetList', function()
    M.list_snippets()
  end, {})
  
  api.nvim_create_user_command('SnippetDelete', function()
    M.delete_snippet()
  end, {})
end

return M
