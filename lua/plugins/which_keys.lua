-- lua/plugins/which-key-v3.lua
-- Which-key con la sintaxis correcta para v3

return {
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      ---@type false | "classic" | "modern" | "helix"
      preset = "classic",

      -- Delay antes de mostrar el popup (ms)
      delay = function(ctx)
        return ctx.plugin and 0 or 200
      end,

      -- Configuración de triggers automáticos
      triggers = {}, -- ← VACÍO para deshabilitar detección automática

      -- Deshabilitar detección automática completamente
      defer = function(ctx)
        return false -- No mostrar nunca automáticamente
      end,

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

      -- 🎯 SOLO LOS KEYMAPS QUE VOS CONFIGURÉS EXPLÍCITAMENTE
      -- No detecta nada automáticamente, solo muestra estos:

      wk.add({
        -- Configurá SOLO los que querés que aparezcan
        { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find Files" },
        { "<leader>fg", "<cmd>Telescope live_grep<cr>",  desc = "Live Grep" },
        { "<leader>fb", "<cmd>Telescope buffers<cr>",    desc = "Find Buffers" },
        { "gd",         vim.lsp.buf.definition,          desc = "Go to Definition" },
        { "gr",         vim.lsp.buf.references,          desc = "Go to References" },
        { "K",          vim.lsp.buf.hover,               desc = "Hover Doc" },

        -- Agregá acá SOLO los keymaps que querés que aparezcan
        -- El formato es: { "tecla", "comando", desc = "descripción" }
      })

      -- Si querés que which-key se abra con una tecla específica:
      vim.keymap.set("n", "<leader>", function()
        require("which-key").show({ global = false })
      end, { desc = "Which Key" })
    end,
  },
}

--[[
📋 CONFIGURACIONES PRINCIPALES PARA opts.win:

BORDES:
border = "none"     -- sin borde
border = "single"   -- línea simple
border = "double"   -- línea doble
border = "rounded"  -- esquinas redondeadas
border = "solid"    -- sólido
border = "shadow"   -- con sombra

POSICIÓN Y TAMAÑO:
no_overlap = true           -- no superponer cursor
padding = { 1, 2 }          -- [top/bottom, right/left]
title = true                -- mostrar título
title_pos = "center"        -- "left" | "center" | "right"

TRANSPARENCIA:
wo = { winblend = 10 }      -- 0-100 (0=opaco, 100=transparente)

LAYOUT:
layout = {
  width = { min = 20 },     -- ancho mínimo
  spacing = 3               -- espaciado entre columnas
}

DELAY:
delay = 200                 -- ms antes de mostrar
delay = function(ctx)       -- función dinámica
  return ctx.plugin and 0 or 200
end

ICONOS:
icons = {
  mappings = false          -- deshabilitar todos los iconos
}

PLUGINS:
plugins = {
  marks = false             -- deshabilitar marks popup
  registers = false         -- deshabilitar registers popup
  spelling = { enabled = false } -- deshabilitar spelling
}

COMANDOS ÚTILES:
:WhichKey                   -- mostrar todos los mappings
:checkhealth which-key      -- verificar instalación
]]
