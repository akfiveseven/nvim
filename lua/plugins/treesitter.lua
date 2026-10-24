return {
    "nvim-treesitter/nvim-treesitter",
    -- The "main" branch is a rewrite: it only installs parsers/queries. Highlighting and
    -- indentation are enabled per buffer below. Needs tree-sitter CLI, a C compiler, tar and curl.
    branch = "main",
    build = ":TSUpdate",
    lazy = false, -- Load at startup so syntax highlighting works immediately.
    config = function()
        local ts = require("nvim-treesitter")

        -- Parsers to always have installed (no-op if already installed)
        ts.install({
            "vimdoc", "javascript", "typescript", "c", "lua", "rust", "cpp", "python", "html", "css",
            "jsdoc", "bash", "markdown", "markdown_inline",
        })

        -- Filetypes that also keep regex syntax highlighting alongside treesitter
        local additional_vim_regex_highlighting = { markdown = true }

        local function attach(buf, lang)
            if not vim.api.nvim_buf_is_valid(buf) or not pcall(vim.treesitter.start, buf, lang) then
                return
            end
            if additional_vim_regex_highlighting[vim.bo[buf].filetype] then
                vim.bo[buf].syntax = "ON"
            end
            if vim.treesitter.query.get(lang, "indents") then
                vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
            end
        end

        vim.api.nvim_create_autocmd("FileType", {
            group = vim.api.nvim_create_augroup("treesitter_setup", { clear = true }),
            callback = function(args)
                local buf = args.buf
                local lang = vim.treesitter.language.get_lang(args.match)
                if not lang then return end

                if vim.list_contains(ts.get_installed(), lang) then
                    attach(buf, lang)
                elseif vim.list_contains(ts.get_available(), lang) then
                    -- Automatically install missing parsers when entering buffer
                    ts.install({ lang }):await(vim.schedule_wrap(function() attach(buf, lang) end))
                else
                    attach(buf, lang) -- parsers bundled with Neovim (e.g. query, vim)
                end
            end,
        })
    end
}
