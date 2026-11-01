local keymap = vim.keymap

-- Set <leader> to space (must be set before lazy.nvim)
vim.g.mapleader = " "

-- Basics
keymap.set("n", "<leader>nh", ":noh<CR>")
keymap.set("n", "x", '"_x')
keymap.set("n", "<C-a>", "ggVG")
keymap.set({ "n", "v" }, "t", "<S-$>")
keymap.set({ "n", "v" }, "<S-T>", "^^")
keymap.set("n", "<CR>", "o<Esc>")

-- Tabs
keymap.set("n", "<leader>t", ":$tabnew<CR>")
keymap.set("n", "<leader><S-t>", ":tabclose<CR>")
keymap.set("n", "<Tab>l", ":tabn<CR>")
keymap.set("n", "<Tab>h", ":tabp<CR>")
keymap.set("n", "<Tab>j", ":-tabmove<CR>")
keymap.set("n", "<Tab>k", ":+tabmove<CR>")

-- Open terminal (uses the system default shell)
keymap.set("n", "cmd", ":terminal<CR>i")
-- Close terminal
keymap.set("t", "<C-c>", "<C-\\><C-n>")
keymap.set("t", "<CS-c>", "<C-c>")

-- Split window
keymap.set("n", "ss", "<C-w>s")
keymap.set("n", "sv", "<C-w>v")
keymap.set("n", "sc", "<C-w>c")

-- Move window
keymap.set("n", "sh", "<C-w>h")
keymap.set("n", "sk", "<C-w>k")
keymap.set("n", "sj", "<C-w>j")
keymap.set("n", "sl", "<C-w>l")

-- Resize window
keymap.set("n", "<C-h>", "<C-w><")
keymap.set("n", "<C-l>", "<C-w>>")
keymap.set("n", "<C-k>", "<C-w>+")
keymap.set("n", "<C-j>", "<C-w>-")

-- Fast commenting (vim-commentary)
keymap.set({ "n", "v" }, "<leader>co", ":Commentary<CR>")

-- Lazy (plugin manager)
keymap.set("n", "<leader>ps", ":Lazy sync<CR>")
keymap.set("n", "<leader>pS", ":Lazy<CR>")

-- Nvim-tree keymap
keymap.set("n", "<leader>ee", ":NvimTreeToggle<CR>")
keymap.set("n", "<leader>ef", ":NvimTreeFindFileToggle<CR>")
keymap.set("n", "<leader>ec", ":NvimTreeCollapse<CR>")
keymap.set("n", "<leader>er", ":NvimTreeRefresh<CR>")

-- Telescope keymaps
keymap.set("n", "<leader>ff", ":Telescope find_files<CR>")
keymap.set("n", "<leader>fr", ":Telescope oldfiles<CR>")
keymap.set("n", "<leader>fw", ":Telescope live_grep<CR>")
keymap.set("n", "<leader>fc", ":Telescope grep_string<CR>")

-- LazyGit Keymap
keymap.set("n", "<leader>lg", ":LazyGit<CR>")

-- Conform Keymap
keymap.set({ "n", "v" }, "<leader>fm", function()
  require("conform").format({ lsp_fallback = true, async = false, timeout_ms = 500 })
end)

-- Clock
keymap.set("n", "<leader><leader>t", ":ClockShowTime<CR>")
keymap.set("n", "<leader><leader>s", ":ClockSelectTime<CR>")
keymap.set("n", "<leader><leader>dt", ":ClockToggleTimer<CR>")
