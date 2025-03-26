-- Name of your colorscheme
local name = 'custom_theme'

-- Color palette
local colors = {
    -- Base colors
    bg = '#0a0b16',           -- Deep space black with slight purple tint
    fg = '#e2e8f0',           -- Starlight white
    gray = '#516187',         -- Nebula dust
    blue = '#7aa2f7',         -- Cosmic blue
    green = '#7dd3a8',        -- Celestial green
    purple = '#9d7cd8',       -- Galaxy purple
    bright_purple = '#bb9af7', -- Bright nebula purple
    cyan = '#89ddff',         -- Stellar blue
    deep_blue = '#3d59a1',    -- Deep space blue
    white = '#ffffff',        -- Pure white for stars
    
    -- Darker/lighter variants
    bg_dark = '#070813',      -- Deeper space black
    bg_lighter = '#171b30',   -- Lighter space background
    fg_dark = '#a9b1d6',      -- Dimmer starlight
}

-- Set up the colorscheme
local function setup()
    -- Clear existing highlighting
    vim.cmd('highlight clear')
    
    if vim.fn.exists('syntax_on') then
        vim.cmd('syntax reset')
    end
    
    -- Set colorscheme name
    vim.g.colors_name = name
    
    -- Define highlight groups
    local groups = {
        -- Editor groups
        Normal = { fg = colors.fg, bg = colors.bg },
        NormalFloat = { fg = colors.fg, bg = colors.bg_dark },
        Cursor = { fg = colors.bg, bg = colors.fg },
        CursorLine = { bg = colors.bg_lighter },
        LineNr = { fg = colors.gray },
        CursorLineNr = { fg = colors.fg },
        
        -- Syntax groups
        Comment = { fg = colors.gray, italic = true },
        String = { fg = colors.green },
        Number = { fg = colors.bright_purple },
        Function = { fg = colors.blue },
        Keyword = { fg = colors.purple },
        Conditional = { fg = colors.purple },
        Type = { fg = colors.cyan },
        Identifier = { fg = colors.white },
        Special = { fg = colors.bright_purple },
        
        -- UI elements
        StatusLine = { fg = colors.fg, bg = colors.bg_dark },
        StatusLineNC = { fg = colors.gray, bg = colors.bg_dark },
        VertSplit = { fg = colors.gray },
        TabLine = { fg = colors.fg, bg = colors.bg_dark },
        TabLineFill = { bg = colors.bg_dark },
        TabLineSel = { fg = colors.bg, bg = colors.blue },
        
        -- Search and selection
        Search = { fg = colors.bg, bg = colors.yellow },
        IncSearch = { fg = colors.bg, bg = colors.orange },
        Visual = { bg = colors.bg_lighter },
        
        -- Git signs
        SignColumn = { bg = colors.bg },
        GitSignsAdd = { fg = colors.green },
        GitSignsChange = { fg = colors.blue },
        GitSignsDelete = { fg = colors.red },
        
        -- Diagnostic signs
        DiagnosticError = { fg = colors.red },
        DiagnosticWarn = { fg = colors.yellow },
        DiagnosticInfo = { fg = colors.blue },
        DiagnosticHint = { fg = colors.cyan },
    }
    
    -- Apply highlights
    for group, settings in pairs(groups) do
        vim.api.nvim_set_hl(0, group, settings)
    end
end

return {
    setup = setup,
    colors = colors,
}
