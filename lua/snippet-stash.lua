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



-- Show snippet menu with Telescope integration
function M.show_snippets()
  local ft = get_filetype()
  
  if not snippets[ft] or #snippets[ft] == 0 then
    print('No snippets saved for filetype: ' .. ft)
    return
  end
  
  -- Try to use Telescope if available
  local has_telescope, telescope = pcall(require, 'telescope')
  if has_telescope then
    local pickers = require('telescope.pickers')
    local finders = require('telescope.finders')
    local conf = require('telescope.config').values
    local actions = require('telescope.actions')
    local action_state = require('telescope.actions.state')
    local previewers = require('telescope.previewers')
    
    pickers.new({}, {
      prompt_title = 'Snippets (' .. ft .. ')',
      finder = finders.new_table({
        results = snippets[ft],
        entry_maker = function(entry)
          return {
            value = entry,
            display = entry.name,
            ordinal = entry.name,
          }
        end,
      }),
      sorter = conf.generic_sorter({}),
      previewer = previewers.new_buffer_previewer({
        define_preview = function(self, entry)
          local lines = vim.split(entry.value.content, '\n')
          vim.api.nvim_buf_set_lines(self.state.bufnr, 0, -1, false, lines)
          vim.api.nvim_buf_set_option(self.state.bufnr, 'filetype', ft)
        end,
      }),
      attach_mappings = function(prompt_bufnr)
        actions.select_default:replace(function()
          local selection = action_state.get_selected_entry()
          actions.close(prompt_bufnr)
          
          -- Find index of selected snippet
          for i, snippet in ipairs(snippets[ft]) do
            if snippet.name == selection.value.name then
              M.insert_snippet(ft, i)
              break
            end
          end
        end)
        return true
      end,
    }):find()
  else
    -- Fallback to custom picker if Telescope not available
    M.show_snippets_with_preview()
  end
end

-- Fuzzy matching function
local function fuzzy_match(str, pattern)
  if pattern == '' then
    return true, 0
  end
  
  local str_lower = str:lower()
  local pattern_lower = pattern:lower()
  local score = 0
  local str_idx = 1
  
  for i = 1, #pattern_lower do
    local char = pattern_lower:sub(i, i)
    local found_idx = str_lower:find(char, str_idx, true)
    
    if not found_idx then
      return false, 0
    end
    
    -- Higher score for consecutive matches
    if found_idx == str_idx then
      score = score + 2
    else
      score = score + 1
    end
    
    str_idx = found_idx + 1
  end
  
  return true, score
end

-- Show snippet menu with custom picker and live preview
function M.show_snippets_with_preview()
  local ft = get_filetype()
  
  if not snippets[ft] or #snippets[ft] == 0 then
    print('No snippets saved for filetype: ' .. ft)
    return
  end
  
  local current_idx = 1
  local preview_buf = nil
  local preview_win = nil
  local menu_buf = nil
  local menu_win = nil
  local prompt_buf = nil
  local prompt_win = nil
  local search_query = ''
  local filtered_snippets = vim.deepcopy(snippets[ft])
  
  -- Create menu buffer
  menu_buf = api.nvim_create_buf(false, true)
  
  -- Create prompt buffer
  prompt_buf = api.nvim_create_buf(false, true)
  
  local function filter_snippets()
    if search_query == '' then
      filtered_snippets = vim.deepcopy(snippets[ft])
    else
      filtered_snippets = {}
      local scored = {}
      
      for _, snippet in ipairs(snippets[ft]) do
        local match, score = fuzzy_match(snippet.name, search_query)
        if match then
          table.insert(scored, {snippet = snippet, score = score})
        end
      end
      
      -- Sort by score (higher is better)
      table.sort(scored, function(a, b) return a.score > b.score end)
      
      for _, item in ipairs(scored) do
        table.insert(filtered_snippets, item.snippet)
      end
    end
    
    -- Reset index if out of bounds
    if current_idx > #filtered_snippets then
      current_idx = math.max(1, #filtered_snippets)
    end
  end
  
  local function update_prompt()
    local prompt_text = '> ' .. search_query
    api.nvim_buf_set_option(prompt_buf, 'modifiable', true)
    api.nvim_buf_set_lines(prompt_buf, 0, -1, false, {prompt_text})
    api.nvim_buf_set_option(prompt_buf, 'modifiable', false)
  end
  
  local function update_menu()
    local lines = {}
    for i, snippet in ipairs(filtered_snippets) do
      local prefix = i == current_idx and '> ' or '  '
      table.insert(lines, prefix .. snippet.name)
    end
    
    if #lines == 0 then
      lines = {'  No matches'}
    end
    
    api.nvim_buf_set_option(menu_buf, 'modifiable', true)
    api.nvim_buf_set_lines(menu_buf, 0, -1, false, lines)
    api.nvim_buf_set_option(menu_buf, 'modifiable', false)
  end
  
  local function update_preview()
    if preview_win and api.nvim_win_is_valid(preview_win) then
      api.nvim_win_close(preview_win, true)
    end
    if preview_buf and api.nvim_buf_is_valid(preview_buf) then
      api.nvim_buf_delete(preview_buf, { force = true })
    end
    
    if #filtered_snippets == 0 then
      return
    end
    
    -- Create preview buffer
    local content_lines = vim.split(filtered_snippets[current_idx].content, '\n')
    preview_buf = api.nvim_create_buf(false, true)
    api.nvim_buf_set_lines(preview_buf, 0, -1, false, content_lines)
    api.nvim_buf_set_option(preview_buf, 'modifiable', false)
    api.nvim_buf_set_option(preview_buf, 'filetype', ft)
    
    -- Get menu window position
    local menu_config = api.nvim_win_get_config(menu_win)
    
    -- Create preview window to the right of menu
    preview_win = api.nvim_open_win(preview_buf, false, {
      relative = 'editor',
      width = 60,
      height = menu_config.height,
      col = menu_config.col + menu_config.width + 1,
      row = menu_config.row,
      style = 'minimal',
      border = 'rounded',
      title = ' Preview ',
      title_pos = 'center',
    })
    
    api.nvim_win_set_option(preview_win, 'winhl', 'Normal:Normal,FloatBorder:FloatBorder')
  end
  
  local function cleanup()
    if prompt_win and api.nvim_win_is_valid(prompt_win) then
      api.nvim_win_close(prompt_win, true)
    end
    if prompt_buf and api.nvim_buf_is_valid(prompt_buf) then
      api.nvim_buf_delete(prompt_buf, { force = true })
    end
    if menu_win and api.nvim_win_is_valid(menu_win) then
      api.nvim_win_close(menu_win, true)
    end
    if menu_buf and api.nvim_buf_is_valid(menu_buf) then
      api.nvim_buf_delete(menu_buf, { force = true })
    end
    if preview_win and api.nvim_win_is_valid(preview_win) then
      api.nvim_win_close(preview_win, true)
    end
    if preview_buf and api.nvim_buf_is_valid(preview_buf) then
      api.nvim_buf_delete(preview_buf, { force = true })
    end
  end
  
  -- Create windows
  local ui = api.nvim_list_uis()[1]
  local menu_width = 35
  local preview_width = 60
  local gap = 1
  local total_width = menu_width + gap + preview_width
  local height = math.min(#snippets[ft] + 2, 25)
  
  -- Center the entire container
  local container_col = math.floor((ui.width - total_width) / 2)
  local row = math.floor((ui.height - height) / 2)
  
  -- Create prompt window
  prompt_win = api.nvim_open_win(prompt_buf, true, {
    relative = 'editor',
    width = menu_width,
    height = 1,
    col = container_col,
    row = row - 2,
    style = 'minimal',
    border = 'rounded',
    title = ' Search ',
    title_pos = 'center',
  })
  
  -- Create menu window
  menu_win = api.nvim_open_win(menu_buf, false, {
    relative = 'editor',
    width = menu_width,
    height = height,
    col = container_col,
    row = row,
    style = 'minimal',
    border = 'rounded',
    title = ' Snippets (' .. ft .. ') ',
    title_pos = 'center',
  })
  
  update_prompt()
  update_menu()
  update_preview()
  
  -- Set up keymaps for prompt window
  local opts = { buffer = prompt_buf, nowait = true, silent = true }
  
  -- Character input
  for i = 32, 126 do
    local char = string.char(i)
    vim.keymap.set('i', char, function()
      search_query = search_query .. char
      filter_snippets()
      current_idx = 1
      update_prompt()
      update_menu()
      update_preview()
    end, opts)
  end
  
  -- Backspace
  vim.keymap.set('i', '<BS>', function()
    if #search_query > 0 then
      search_query = search_query:sub(1, -2)
      filter_snippets()
      current_idx = 1
      update_prompt()
      update_menu()
      update_preview()
    end
  end, opts)
  
  -- Navigation
  vim.keymap.set('i', '<C-n>', function()
    if current_idx < #filtered_snippets then
      current_idx = current_idx + 1
      update_menu()
      update_preview()
    end
  end, opts)
  
  vim.keymap.set('i', '<C-p>', function()
    if current_idx > 1 then
      current_idx = current_idx - 1
      update_menu()
      update_preview()
    end
  end, opts)
  
  vim.keymap.set('i', '<Down>', function()
    if current_idx < #filtered_snippets then
      current_idx = current_idx + 1
      update_menu()
      update_preview()
    end
  end, opts)
  
  vim.keymap.set('i', '<Up>', function()
    if current_idx > 1 then
      current_idx = current_idx - 1
      update_menu()
      update_preview()
    end
  end, opts)
  
  -- Select
  vim.keymap.set('i', '<CR>', function()
    if #filtered_snippets > 0 then
      -- Find the original index
      local selected = filtered_snippets[current_idx]
      local original_idx = nil
      for i, snippet in ipairs(snippets[ft]) do
        if snippet.name == selected.name then
          original_idx = i
          break
        end
      end
      
      cleanup()
      if original_idx then
        M.insert_snippet(ft, original_idx)
      end
    end
  end, opts)
  
  -- Exit
  vim.keymap.set('i', '<Esc>', cleanup, opts)
  vim.keymap.set('i', '<C-c>', cleanup, opts)
  
  -- Enter insert mode
  vim.cmd('startinsert')
  
  -- Clean up on buffer leave
  api.nvim_create_autocmd('BufLeave', {
    buffer = prompt_buf,
    once = true,
    callback = cleanup,
  })
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
  api.nvim_create_user_command('SnippetSave', function(opts)
    M.save_snippet(opts)
  end, { range = true })
  
  api.nvim_create_user_command('SnippetShow', function()
    M.show_snippets_with_preview()
  end, {})
  
  api.nvim_create_user_command('SnippetList', function()
    M.list_snippets()
  end, {})
  
  api.nvim_create_user_command('SnippetDelete', function()
    M.delete_snippet()
  end, {})
end

return M
