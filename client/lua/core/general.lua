vim.opt.encoding = "utf-8"
vim.opt.fileencoding = "utf-8"

vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.title = true

vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.smarttab = true
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.breakindent = true

vim.opt.hlsearch = true
vim.opt.ignorecase = true
vim.opt.backup = false
vim.opt.scrolloff = 10
vim.opt.backspace = { "start", "eol", "indent" }

vim.opt.mouse = "a"

-- Disable netrw, nvim-tree takes over (must happen before plugins load)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
