return {
    {
        "L3MON4D3/LuaSnip",
        -- follow latest release.
        version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
        -- install jsregexp (optional!).
        build = "make install_jsregexp",

        dependencies = { "rafamadriz/friendly-snippets" },

        config = function()
            local ls = require("luasnip")
            local s = ls.snippet
            local t = ls.text_node
            local i = ls.insert_node
            local extras = require("luasnip.extras")
            local rep = extras.rep
            local fmt = require("luasnip.extras.fmt").fmt

            vim.keymap.set({ "i", "s" }, "<c-n>", function()
                if ls.expand_or_jumpable() then
                    ls.expand_or_jump()
                end
            end, { silent = true })

            vim.keymap.set({ "i", "s" }, "<c-p>", function()
                if ls.jumpable(-1) then
                    ls.jump(-1)
                end
            end, { silent = true })



            ls.add_snippets("python", {
                s("myfor", {
                    t("hello "),
                    i(0),
                    t(" bye"),
                    i(1)
                }),
            })

            -- Traverse a Map in C++
            -- unordered_map<string, int>

            ls.add_snippets("cpp", {
                s("myTraverseMap", {
                    t("unordered_map<string, int> map;"),
                    t({ "", "" }),
                    t("for (const auto& pair : map) {"),
                    t({ "", "\t" }),
                    i(1),
                    t({ "", "" }),
                    t("}"),
                }),
            })

            ls.add_snippets("css", {
                s("root", {
                    t("myroot"),
                }),
            })


            ls.add_snippets("javascriptreact", {
                s("component", {
                    t("const "),
                    i(1),
                    t(" = ("),
                    i(2),
                    t(") => {"),
                    t({ "", "\t" }),
                    t("return ("),
                    t({ "", "\t\t" }),
                    t("<>"),
                    t({ "", "\t\t\t" }),
                    i(0),
                    t({ "", "\t\t" }),
                    t("</>"),
                    t({ "", "\t" }),
                    t(")"),
                    t({ "", "};" }),
                }),
                s("div", {
                    t("<div className='"),
                    i(1),
                    t("'>"),
                    t({ "", "\t" }),
                    i(0),
                    t({ "", "" }),
                    t("</div>"),
                }),
                s("useEffect", {
                    t("useEffect(() => {"),
                    t({ "", "\t" }),
                    t("// Side effect logic"),
                    t({ "", "\t" }),
                    t("return () => {"),
                    t({ "", "\t\t" }),
                    t("// Optional cleanup logic"),
                    t({ "", "\t" }),
                    t("};"),
                    t({ "", "" }),
                    t("}, []);"),

                }),
            })

            ls.add_snippets("typescriptreact", {
                s("component", {
                    t("const "),
                    i(1),
                    t(" = ("),
                    i(2),
                    t(") => {"),
                    t({ "", "\t" }),
                    t("return ("),
                    t({ "", "\t\t" }),
                    t("<>"),
                    t({ "", "\t\t\t" }),
                    i(0),
                    t({ "", "\t\t" }),
                    t("</>"),
                    t({ "", "\t" }),
                    t(")"),
                    t({ "", "};" }),
                }),
                s("div", {
                    t("<div className='"),
                    i(1),
                    t("'>"),
                    t({ "", "\t" }),
                    i(0),
                    t({ "", "" }),
                    t("</div>"),
                }),
                s("useEffect", {
                    t("useEffect(() => {"),
                    t({ "", "\t" }),
                    t("// Side effect logic"),
                    t({ "", "\t" }),
                    t("return () => {"),
                    t({ "", "\t\t" }),
                    t("// Optional cleanup logic"),
                    t({ "", "\t" }),
                    t("};"),
                    t({ "", "" }),
                    t("}, []);"),

                }),
            })


            -- local ls = require("luasnip")
            -- ls.filetype_extend("javascript", { "jsdoc" })
            --
            -- --- TODO: What is expand?
            -- vim.keymap.set({"i"}, "<C-s>e", function() ls.expand() end, {silent = true})
            --
            -- vim.keymap.set({"i", "s"}, "<C-s>;", function() ls.jump(1) end, {silent = true})
            -- vim.keymap.set({"i", "s"}, "<C-s>,", function() ls.jump(-1) end, {silent = true})
            --
            -- vim.keymap.set({"i", "s"}, "<C-E>", function()
            --     if ls.choice_active() then
            --         ls.change_choice(1)
            --     end
            -- end, {silent = true})
        end,
    }
}

