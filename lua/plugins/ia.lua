return {
  {
    "Exafunction/codeium.vim",
    event = "InsertEnter",
    config = function()
      vim.g.codeium_disable_bindings = 1
      -- Keymaps que no chocan con nvim-cmp
      vim.keymap.set("i", "<C-g>", function() return vim.fn["codeium#Accept"]() end,
        { expr = true, desc = "Codeium Accept" })
      vim.keymap.set("i", "<C-]>", function() return vim.fn end, { expr = true })
      vim.keymap.set("i", "<C-[>", function() return vim.fn["codeium#CycleCompletions"](-1) end, { expr = true })
      vim.keymap.set("i", "<C-\\>", function() return vim.fn["codeium#Clear"]() end, { expr = true })
    end,
  }
}
