-- nvim-configs: "client" profile

-- Find repo root: ~/.config/nvim is a symlink to <repo>/client
local config_dir = vim.fn.resolve(vim.fn.stdpath("config"))
local repo_root = vim.fn.fnamemodify(config_dir, ":h")

-- Load shared modules (e.g. the updater) from <repo>/shared
vim.opt.rtp:prepend(repo_root .. "/shared")
local ok, updater = pcall(require, "nvim_configs.updater")
if ok then
  updater.setup({ repo = repo_root })
end

require("core.general")
require("core.keymaps")
require("core.lazy")
