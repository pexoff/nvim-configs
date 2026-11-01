-- Install lazy.nvim if missing (only happens on first launch)
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local out = vim.fn.system({
    "git", "clone", "--filter=blob:none", "--branch=stable",
    "https://github.com/folke/lazy.nvim.git", lazypath,
  })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({ { "Failed to clone lazy.nvim:\n" .. out, "ErrorMsg" } }, true, {})
    return
  end
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  spec = { { import = "plugins" } },

  -- Keep the lockfile per device, outside the repo. This keeps the repo
  -- clean when plugins are updated locally, so the config updater is not
  -- blocked by local changes.
  lockfile = vim.fn.stdpath("data") .. "/lazy-lock.json",

  install = { colorscheme = { "tokyodark", "habamax" } },
  checker = { enabled = false }, -- updates are handled by nvim_configs.updater
  change_detection = { notify = false },
})

-- Update plugins in the background, at most once per hour
vim.api.nvim_create_autocmd("User", {
  pattern = "VeryLazy",
  once = true,
  callback = function()
    local ok, updater = pcall(require, "nvim_configs.updater")
    if ok then
      updater.update_plugins()
    end
  end,
})
