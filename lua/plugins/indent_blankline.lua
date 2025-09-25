return {
  {
    "lukas-reineke/indent-blankline.nvim",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      -- Configuración de las líneas de indentación
      indent = {
        char = "│", -- El carácter para las líneas (también puedes usar "▏", "┊", "┆")
        tab_char = "│", -- Carácter para tabs
      },

      -- Scope highlighting (resalta el bloque actual)
      scope = {
        enabled = true,
        char = "│",
        highlight = "IblScope", -- Highlight group para el scope actual
        include = {
          node_type = {
            ["*"] = {
              "class",
              "function",
              "method",
              "block",
              "list_literal",
              "selector",
              "^if",
              "^table",
              "if_statement",
              "while_statement",
              "for_statement",
            },
          },
        },
      },

      -- Excluir ciertos tipos de archivo
      exclude = {
        filetypes = {
          "help",
          "alpha",
          "dashboard",
          "neo-tree",
          "Trouble",
          "trouble",
          "lazy",
          "mason",
          "notify",
          "toggleterm",
          "lazyterm",
          "startify",
        },
        buftypes = {
          "terminal",
          "nofile",
        },
      },

      -- Configuraciones adicionales
      whitespace = {
        remove_blankline_trail = false,
      },
    },
    main = "ibl",
    config = function(_, opts)
      require("ibl").setup(opts)

      -- Configurar colores personalizados
      vim.api.nvim_create_autocmd("ColorScheme", {
        callback = function()
          vim.api.nvim_set_hl(0, "IblIndent", { fg = "#3C4048", nocombine = true })
          vim.api.nvim_set_hl(0, "IblScope", { fg = "#7C3AED", nocombine = true })
        end,
      })

      -- Aplicar colores ahora
      vim.api.nvim_set_hl(0, "IblIndent", { fg = "#3C4048", nocombine = true })
      vim.api.nvim_set_hl(0, "IblScope", { fg = "#7C3AED", nocombine = true })
    end,
  } }
