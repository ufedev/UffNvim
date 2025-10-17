return {
  {
    'L3MON4D3/LuaSnip',
    dependencies = {
      'rafamadriz/friendly-snippets',
    },
    config = function()
      require('luasnip.loaders.from_vscode').lazy_load()
      local ls = require('luasnip')
      local s = ls.snippet
      local t = ls.text_node
      local i = ls.insert_node

      ls.add_snippets("html", {
        s("html5", {
          t({
            "<!DOCTYPE html>",
            "<html lang=\"es\">",
            "<head>",
            "    <meta charset=\"UTF-8\">",
            "    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">",
            "    <title>"
          }),
          i(1, "Título"),
          t({
            "</title>",
            "</head>",
            "<body>",
            "    "
          }),
          i(2),
          t({
            "",
            "</body>",
            "</html>"
          })
        })
      })
    end
  }
}
