return {
  {
    "L3MON4D3/LuaSnip",
    -- follow latest release.
    version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
    -- install jsregexp (optional!).
    build = "make install_jsregexp",

    -- dependencies = { "rafamadriz/friendly-snippets" },

    config = function()
      local ls = require("luasnip")
      require("luasnip.loaders.from_vscode").lazy_load()
      local s = ls.snippet
      local t = ls.text_node
      local i = ls.insert_node
      -- local extras = require("luasnip.extras")
      -- local rep = extras.rep
      -- local fmt = require("luasnip.extras.fmt").fmt

      vim.keymap.set({ "i", "s" }, "<tab>", function()
        if ls.expand_or_jumpable() then
          ls.expand_or_jump()
        end
      end, { silent = true })

      vim.keymap.set({ "i", "s" }, "<s-tab>", function()
        if ls.jumpable(-1) then
          ls.jump(-1)
        end
      end, { silent = true })

      -- =======CSS SNIPPETS======= --

      ls.add_snippets("css", {
        s("root", {
          t("myroot"),
        }),
      })



      -- =======lua snippets======= --

      ls.add_snippets("lua", {
        s({ name = "snippet-luasnip", trig = "snippet", dscr = { "Define a luasnip snippet." } }, {
          t("s({ name = \""),
          i(1),
          t("\", trig = \""),
          i(2),
          t("\", dscr = { \""),
          i(3),
          t("\" } }, {"),
          t({"", "\t"}),
          t("t("),
          i(4),
          t("),"),
          t({"", ""}),
          t("}),"),
        }),
      })

      -- =======PYTHON SNIPPETS======= --

      ls.add_snippets("python", {

        -- Core snippets
        s({ name = "main", trig = "main", dscr = { "python main module guard" } }, {
            t('if __name__ == "__main__":'), t({"", "\t"}), i(0),
        }),

        s({ name = "if", trig = "if", dscr = { "if statement" }}, {
          t("if "), i(1), t(":"), t({"", "\t"}), i(2)
        }),

        s({name = "else", trig = "else", dscr = { "else statement" } }, {
          t("else:"), t({"", "\t"}), i(1)
        }),

        s({name = "elif", trig = "elif", dscr = { "elif statement" } }, {
          t("elif "), i(1), t(":"), t({"", "\t"}), i(2)
        }),

        s({ name = "for-dict", trig = "for", dscr = { "Iterate over dictionary" } }, {
          t("for key, value in "),
          i(1),
          t(".items():"),
          t({"", "\t"}),
          t("print(f\"{key}: {value}\")"),
          i(2)
        }),

        s({ name = "for-range", trig = "for", dscr = { "Range-based for loop" } }, {
          t("for "),
          i(1),
          t(" in range("),
          i(2),
          t("):"),
          t({"", "\t"}),
          i(3)
        }),


        s({ name = "function-definition", trig = "function", dscr = { "Define a function." } }, {
          t("def "),
          i(1),
          t("("),
          i(2),
          t("):"),
          t({"", "\t"}),
          i(3)
        }),

        s({ name = "list", trig = "list", dscr = { "Define a list." } }, {
          i(1),
          t(" = ["),
          i(2),
          t("]")
        }),

        s({ name = "tuple", trig = "tuple", dscr = { "Insert a dummy tuple." } }, {
          t("point = (3, 4)"),
          t({"", ""}),
          t({"", ""}),
          t("# tuple unpacking"),
          t({"", ""}),
          t("x, y = point")
        }),

        s({ name = "set", trig = "set", dscr = { "Insert a dummy set." } }, {
          t("unique_vals = {1, 2, 3}")
        }),

        s({ name = "dictionary", trig = "dictionary", dscr = { "Insert a dummy dictionary." } }, {
          t("person = {\"name\": \"Alice\", \"age\": 30}")
        }),

        s({ name = "class", trig = "class", dscr = { "Define a class." } }, {
          t("class "),
          i(1),
          t(":"),
          t({"", "\t"}),
          t("def __init__(self"),
          i(2),
          t("):"),
          t({"", "\t\t"}),
          i(3)
        }),

        s({ name = "try", trig = "try", dscr = { "Define a try statement." } }, {
          t("try:"),
          t({"", "\t"}),
          i(2),
          t({"", ""}),
          t("except "),
          i(1),
          t(":"),
          t({"", "\t"}),
          i(3),
          t({"", ""}),
          t("finally:"),
          t({"", "\t"}),
          i(4)
        }),

        s({ name = "type", trig = "type", dscr = { "type() function" } }, {
          t("type("),
          i(1),
          t(")")
        }),

        s({ name = "type-instance", trig = "instance", dscr = { "Check instance/type of a object." } }, {
          t("isinstance(\"hi\", str) # True"),
        }),

      })

      -- ======= cpp snippets ======= --

      ls.add_snippets("cpp", {
      })

      -- =======JAVASCRIPT SNIPPETS======= --

      ls.add_snippets("javascript", {
      })

      ls.add_snippets("javascriptreact", {

        s({ name = "div", trig = "div", dscr = { "div" } }, {
          t("<div"),
          i(1),
          t(">"),
          t({"", ""}),
          t("</div>")
        }),

        s({ name = "arrow-function", trig = "function", dscr = { "Create an arrow function." } }, {
          t("const "),
          i(1),
          t(" = ("),
          i(2),
          t(") => {"),
          t({ "", "\t" }),
          t("return ("),
          t({ "", "\t\t" }),
          i(0),
          t({ "", "\t" }),
          t(");"),
          t({ "", "};" }),
        }),

        s({ name = "useEffect", trig = "useEffect", dscr = { "Create a useEffect block." } }, {
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

        s({ name = "className", trig = "className", dscr = { "Add classname attribute." } }, {
          t("className=\""),
          i(1),
          t("\"")
        }),

        s({ name = "map", trig = "map", dscr = { "Iterate over a list (array)." } }, {
          t("map((item"),
          i(1),
          t(", index) => {"),
          t({"", "\t"}),
          i(2),
          t({"", ""}),
          t("});")
        }),

        s({ name = "filter", trig = "filter", dscr = { "Filters an array" } }, {
          t("filter((item, index) => index % 2 === 0);"),
        }),

        s({ name = "useState", trig = "useState", expr = {  } }, {
          t("const ["),
          i(1),
          t(", "),
          i(2),
          t("] = useState("),
          i(3),
          t(");")
        }),

        s({ name = "default", trig = "default", dscr = { "Export default function." } }, {
          t("export default function "),
          i(1),
          t("()"),
          t(" {"),
          t({"", "\t"}),
          t("return ("),
          t({"", "\t\t"}),
          i(2),
          t({"", "\t"}),
          t(");"),
          t({"", ""}),
          t("};")
        }),

        s({ name = "interface", trig = "interface", dscr = { "Create interface" } }, {
          t("interface "),
          i(1),
          t(" {"),
          t({"", "\t"}),
          i(2),
          t({"", ""}),
          t("}")
        }),

      })

      --== TYPESCRIPT snippets

      ls.add_snippets("typescriptreact", {

        s({ name = "div", trig = "div", dscr = { "div" } }, {
          t("<div"),
          i(1),
          t(">"),
          t({"", ""}),
          t("</div>")
        }),

        s({ name = "arrow-function", trig = "function", dscr = { "Create an arrow function." } }, {
          t("const "),
          i(1),
          t(" = ("),
          i(2),
          t(") => {"),
          t({ "", "\t" }),
          t("return ("),
          t({ "", "\t\t" }),
          i(0),
          t({ "", "\t" }),
          t(");"),
          t({ "", "};" }),
        }),

        s({ name = "if statement", trig = "if", dscr = { "Create an if statement" } }, {
          t("if ("),
          i(1),
          t(") {"),
          t({"", "\t"}),
          i(2),
          t("}")
        }),

        s({ name = "else if statement", trig = "else if", dscr = { "Create an else if statement" } }, {
          t("else if ("),
          i(1),
          t(") {"),
          t({"", "\t"}),
          i(2),
          t("}")
        }),

        s({ name = "useEffect", trig = "useEffect", dscr = { "Create a useEffect block." } }, {
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

        s({ name = "className", trig = "className", dscr = { "Add classname attribute." } }, {
          t("className=\""),
          i(1),
          t("\"")
        }),

        s({ name = "map", trig = "map", dscr = { "Iterate over a list (array)." } }, {
          t("map((item"),
          i(1),
          t(", index) => {"),
          t({"", "\t"}),
          i(2),
          t({"", ""}),
          t("});")
        }),

        s({ name = "filter", trig = "filter", dscr = { "Filters an array" } }, {
          t("filter((item, index) => index % 2 === 0);"),
        }),

        s({ name = "useState", trig = "useState", expr = {  } }, {
          t("const ["),
          i(1),
          t(", "),
          i(2),
          t("] = useState("),
          i(3),
          t(");")
        }),

        s({ name = "default", trig = "default", dscr = { "Export default function." } }, {
          t("export default function "),
          i(1),
          t("()"),
          t(" {"),
          t({"", "\t"}),
          t("return ("),
          t({"", "\t\t"}),
          i(2),
          t({"", "\t"}),
          t(");"),
          t({"", ""}),
          t("};")
        }),

        s({ name = "interface", trig = "interface", dscr = { "Create interface" } }, {
          t("interface "),
          i(1),
          t(" {"),
          t({"", "\t"}),
          i(2),
          t({"", ""}),
          t("}")
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

