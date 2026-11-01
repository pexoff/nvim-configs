-- nvim-configs: "server" profile
-- Intentionally minimal. To be built from scratch.

-- Find repo root: ~/.config/nvim is a symlink to <repo>/server
local config_dir = vim.fn.resolve(vim.fn.stdpath("config"))
local repo_root = vim.fn.fnamemodify(config_dir, ":h")

-- Auto-update the config from the repo
vim.opt.rtp:prepend(repo_root .. "/shared")
local ok, updater = pcall(require, "nvim_configs.updater")
if ok then
  updater.setup({ repo = repo_root })
end

-- The actual server config goes below.
