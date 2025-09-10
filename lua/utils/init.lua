------------------------------------------------------------
-- Utils AutoInstall dependencies
------------------------------------------------------------
vim.diagnostic.config({
  virtual_text = true,
  severity_sort = true,
  float = { border = 'rounded' }
})

-- Auto-install Tailwind CSS via npm (fallback)
vim.defer_fn(function()
  if vim.fn.executable("npm") == 1 and vim.fn.executable("tailwindcss-language-server") == 0 then
    vim.notify("Installing Tailwind CSS Language Server...")
    vim.fn.system("npm install -g @tailwindcss/language-server")
  end
end, 5000)
