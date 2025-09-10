-- En lua/plugins/ui.lua
return {
  {
    'nvimdev/dashboard-nvim',
    event = 'VimEnter',
    lazy=false,
    priority=1000,
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require('dashboard').setup({
        theme = 'doom',
        config = {
          header = {
            "                                                     ",
            "  ██╗   ██╗███████╗███████╗███╗   ██╗██╗   ██╗██╗███╗   ███╗",
            "  ██║   ██║██╔════╝██╔════╝████╗  ██║██║   ██║██║████╗ ████║",
            "  ██║   ██║█████╗  █████╗  ██╔██╗ ██║██║   ██║██║██╔████╔██║",
            "  ██║   ██║██╔══╝  ██╔══╝  ██║╚██╗██║╚██╗ ██╔╝██║██║╚██╔╝██║",
            "  ╚██████╔╝██║     ██║     ██║ ╚████║ ╚████╔╝ ██║██║ ╚═╝ ██║",
            "   ╚═════╝ ╚═╝     ╚═╝     ╚═╝  ╚═══╝  ╚═══╝  ╚═╝╚═╝     ╚═╝",
            "                                                     ",
            "               🚀 UffNvim - Ready to code! 🚀        ",
            "",
          },
          center = {

            {
              icon = '󰈞  ',
              desc = 'Find files                            ',
              key = 'f',
              action = 'Telescope find_files'
            },
            {
              icon = '󰊄  ',
              desc = 'Recent files                          ',
              key = 'r',
              action = 'Telescope oldfiles'
            },
            {
              icon = '󰈬  ',
              desc = 'Find text                             ',
              key = 't',
              action = 'Telescope live_grep'
            },
            {
              icon = '󰙅  ',
              desc = 'Open Current                          ',
              key = 'c',
              action = 'NvimTreeFocus'
            },
            {
              icon = '󰒲  ',
              desc = 'Lazy                                  ',
              key = 'l',
              action = 'Lazy'
            },
            {
              icon = '󰿅  ',
              desc = 'Quit                                  ',
              key = 'q',
              action = 'quit'
            },
          },
          footer = function()
            local stats = require("lazy").stats()
            local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
            return { "⚡ Neovim loaded " .. stats.loaded .. "/" .. stats.count .. " plugins in " .. ms .. "ms" }
          end,
        }
      })
    end,
  }
}
