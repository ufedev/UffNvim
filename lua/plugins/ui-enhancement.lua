-- lua/plugins/ui-enhancement.lua
-- El cmdline copado que aparece arriba + mensajitos lindos

return {
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = {
      -- Requerido para la UI
      "MunifTanjim/nui.nvim",
      -- Opcional: para notificaciones lindas (lo vemos después)
      -- "rcarriga/nvim-notify",
    },
    opts = {
      lsp = {
        -- Sobrescribir el rendering de markdown para que se vea lindo
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
          ["cmp.entry.get_documentation"] = true, -- solo si usas nvim-cmp
        },
      },

      -- ✨ EL CMDLINE COPADO ✨
      cmdline = {
        enabled = true,
        view = "cmdline_popup", -- Popup en lugar del cmdline normal
        opts = {},
        format = {
          -- Diferentes iconos para diferentes comandos
          cmdline = { pattern = "^:", icon = "", lang = "vim" },
          search_down = { kind = "search", pattern = "^/", icon = "🚀", lang = "regex" },
          search_up = { kind = "search", pattern = "^%?", icon = "🚀", lang = "regex" },
          filter = { pattern = "^:%s*!", icon = "$", lang = "bash" },
          lua = { pattern = { "^:%s*lua%s+", "^:%s*lua%s*=%s*", "^:%s*=%s*" }, icon = "⭕", lang = "lua" },
          help = { pattern = "^:%s*he?l?p?%s+", icon = "" },
          input = {}, -- Para input() function
        },
      },

      -- Mensajes de Neovim más lindos
      messages = {
        enabled = true,
        view = "notify", -- Usar notificaciones para mensajes
        view_error = "notify",
        view_warn = "notify",
        view_history = "messages",
        view_search = "virtualtext",
      },

      -- Popupmenu para completions (opcional)
      popupmenu = {
        enabled = true,
        backend = "nui", -- Cambiar a "cmp" si usas nvim-cmp
        kind_icons = {}, -- Usar iconos por defecto
      },

      -- Presets útiles
      presets = {
        bottom_search = true,         -- Búsqueda clásica en la parte inferior
        command_palette = true,       -- Command palette estilo VSCode con <leader>:
        long_message_to_split = true, -- Mensajes largos van a un split
        inc_rename = false,           -- No habilitar inc-rename automáticamente
        lsp_doc_border = false,       -- Sin borde en documentación LSP
      },

      -- Routes para controlar dónde van los mensajes
      routes = {
        {
          filter = {
            event = "msg_show",
            kind = "",
            find = "written",
          },
          opts = { skip = true },
        },
        {
          filter = {
            event = "msg_show",
            kind = "",
            find = "%d+L, %d+B",
          },
          view = "mini",
        },
      },
    },

    -- Keymaps opcionales
    keys = {
      { "<S-Enter>",   function() require("noice").redirect(vim.fn.getcmdline()) end,                 mode = "c",                 desc = "Redirect Cmdline" },
      { "<leader>snl", function() require("noice").cmd("last") end,                                   desc = "Noice Last Message" },
      { "<leader>snh", function() require("noice").cmd("history") end,                                desc = "Noice History" },
      { "<leader>sna", function() require("noice").cmd("all") end,                                    desc = "Noice All" },
      { "<leader>snd", function() require("noice").cmd("dismiss") end,                                desc = "Dismiss All" },
      { "<c-f>",       function() if not require("noice.lsp").scroll(4) then return "<c-f>" end end,  silent = true,              expr = true,              desc = "Scroll forward",  mode = { "i", "n", "s" } },
      { "<c-b>",       function() if not require("noice.lsp").scroll(-4) then return "<c-b>" end end, silent = true,              expr = true,              desc = "Scroll backward", mode = { "i", "n", "s" } },
    },
  },
}
