return {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },



    config = function()
        require('lualine').setup {
            options = {
                icons_enabled = true,
                -- theme = 'ayu_mirage',
                -- theme = require('custom_theme').theme(),
                component_separators = { left = '', right = ''},
                section_separators = { left = '', right = ''},
                disabled_filetypes = {
                    statusline = {},
                    winbar = {},
                },
                ignore_focus = {},
                always_divide_middle = true,
                globalstatus = false,
                refresh = {
                    statusline = 1000,
                    tabline = 1000,
                    winbar = 1000,
                },
            },
            sections = {
                lualine_a = {
                    {
                        'mode',
                        background = 'transparent',
                    }
                },
                lualine_b = {},
                lualine_c = {
                    {
                        'filename',
                        path = 3,
                        color = { fg = '#FFFFFF' },  -- Make it bright white
                        background = 'transparent',
                    }
                },
                lualine_x = {'encoding', 'fileformat', 'filetype'},
                lualine_y = {'progress'},
                lualine_z = {'location'}
            },
            -- inactive_sections = {},
            tabline = {},
            winbar = {
                -- lualine_a = {'mode'},
                -- lualine_b = {'branch', 'diff', 'diagnostics'},
                -- lualine_c = {'filename'},
                -- lualine_x = {'encoding', 'fileformat', 'filetype'},
                -- lualine_y = {'progress'},
                -- lualine_z = {'location'}
            },
            inactive_winbar = {},
            extensions = {}
        }
    end
}

