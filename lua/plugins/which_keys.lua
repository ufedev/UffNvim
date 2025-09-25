-- lua/plugins/which-key.lua
-- Plugin que muestra los atajos disponibles cuando presionás <leader> o cualquier tecla

return {
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      ---@type false | "classic" | "modern" | "helix"
      preset = "modern",

      -- Delay antes de mostrar el popup (ms)
      delay = function(ctx)
        return ctx.plugin and 0 or 200
      end,

      -- Configuración de triggers automáticos
      triggers = {
        { "<auto>", mode = "nxsot" },
      },

      -- ✨ CONFIGURACIÓN DE VENTANA (opts.win en lugar de opts.window)
      win = {
        -- No permitir que el popup se superponga con el cursor
        no_overlap = true,

        -- Dimensiones
        -- width = 1, -- ancho automático
        -- height = { min = 4, max = 25 },

        -- Posición
        -- col = 0,
        -- row = math.huge, -- abajo

        -- Bordes y estilo
        border = "rounded", -- "none" | "single" | "double" | "rounded" | "solid" | "shadow"
        padding = { 1, 2 }, -- [top/bottom, right/left]
        title = true,
        title_pos = "center",
        zindex = 1000,

        -- Opciones adicionales de ventana
        wo = {
          winblend = 10, -- 0-100, 0=opaco, 100=transparente
        },
        bo = {},
      },

      -- Layout de las columnas
      layout = {
        width = { min = 20 }, -- ancho mínimo de columnas
        spacing = 3,          -- espaciado entre columnas
      },

      -- Configuración de iconos
      icons = {
        breadcrumb = "»", -- símbolo para breadcrumb
        separator = "➜", -- símbolo entre tecla y descripción
        group = "+", -- símbolo para grupos
        ellipsis = "…",

        -- Mapeo de iconos (opcional)
        rules = {
          -- Reglas automáticas para iconos
        },

        -- Colores de iconos
        colors = true,

        -- Deshabilitar completamente los iconos
        mappings = true, -- cambiar a false para deshabilitar iconos
      },

      -- Configuración de teclas especiales
      keys = {
        scroll_down = "<c-d>", -- scroll hacia abajo en el popup
        scroll_up = "<c-u>",   -- scroll hacia arriba en el popup
      },

      ---@type (string|wk.Sorter)[]
      sort = { "local", "order", "group", "alphanum", "mod" },

      ---@type number|fun(node: wk.Node):boolean?
      expand = 0, -- expandir automáticamente grupos con este número de hijos

      -- Filtros para excluir mappings
      ---@type fun(mapping: wk.Mapping):boolean?
      filter = function(mapping)
        -- Ejemplo: excluir mappings de ciertos plugins
        return true
      end,

      -- Configuración de plugins integrados
      plugins = {
        marks = true,       -- mostrar marks cuando presiones ` o '
        registers = true,   -- mostrar registers cuando presiones " o <c-r>
        spelling = {
          enabled = true,   -- z= para spelling suggestions
          suggestions = 20, -- número de sugerencias
        },
        presets = {
          operators = true,    -- ayuda para operators (d, y, c, etc)
          motions = true,      -- ayuda para motions
          text_objects = true, -- ayuda para text objects (i, a)
          windows = true,      -- bindings por defecto para <c-w>
          nav = true,          -- bindings varios para navegación
          z = true,            -- bindings para z prefix
          g = true,            -- bindings para g prefix
        },
      },

      ---@type wk.Win.opts
      replace = {
        key = {
          function(key)
            return require("which-key.view").format(key)
          end,
          -- { "<Space>", "SPC" },
        },
        desc = {
          { "<Plug>%(.*)%)", "%1" },
          { "^%+",           "" },
          { "<[cC]md>",      "" },
          { "<[cC][rR]>",    "" },
          { "<[sS]ilent>",   "" },
          { "^lua%s+",       "" },
          { "^call%s+",      "" },
          { "^:%s*",         "" },
        },
      },

      -- Debugging
      debug = false,
    },
    config = function(_, opts)
      local wk = require("which-key")
      wk.setup(opts)
    end

  } }
