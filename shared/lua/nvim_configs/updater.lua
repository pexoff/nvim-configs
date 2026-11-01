-- nvim-configs: auto-updater
--
-- On startup, checks in the background whether the git repo has new commits
-- and pulls them with "git pull --ff-only". Never blocks startup.
-- Optional: updates lazy.nvim plugins in the background.

local M = {}

local uv = vim.uv or vim.loop
local levels = vim.log.levels

M.opts = {
  interval = 3600, -- seconds between two checks (config and plugins)
  timeout = 15000, -- ms before a git command is aborted (e.g. offline)
}

M.hint = " Restart Neovim to apply."

-- Helpers -----------------------------------------------------------------

local function notify(msg, level)
  vim.schedule(function()
    vim.notify(msg, level or levels.INFO, { title = "nvim-configs" })
  end)
end

-- Returns true if more than `interval` seconds have passed since the last
-- check, and records the current time.
local function due(name, interval)
  local dir = vim.fn.stdpath("state") .. "/nvim-configs"
  local file = dir .. "/" .. name .. ".stamp"
  local stat = uv.fs_stat(file)
  local now = os.time()
  if stat and (now - stat.mtime.sec) < interval then
    return false
  end
  vim.fn.mkdir(dir, "p")
  local fd = io.open(file, "w")
  if fd then
    fd:write(tostring(now))
    fd:close()
  end
  return true
end

-- Runs a git command in the repo. The callback runs in the normal Neovim
-- context (vim.schedule), where all API functions are allowed.
local function git(root, args, cb)
  local cmd = { "git", "-C", root }
  vim.list_extend(cmd, args)
  local ok = pcall(vim.system, cmd, { text = true, timeout = M.opts.timeout }, function(res)
    vim.schedule(function()
      cb(res)
    end)
  end)
  if not ok then
    -- git not installed or similar: give up silently
    return
  end
end

local function read_file(path)
  local fd = io.open(path, "r")
  if not fd then
    return nil
  end
  local content = fd:read("*a")
  fd:close()
  return content
end

-- Config update -----------------------------------------------------------

function M.check_config(root)
  git(root, { "fetch", "--quiet" }, function(fetch)
    if fetch.code ~= 0 then
      return -- offline or no remote: do nothing
    end

    git(root, { "rev-list", "--count", "HEAD..@{u}" }, function(count)
      local behind = tonumber(vim.trim(count.stdout or "")) or 0
      if count.code ~= 0 or behind == 0 then
        return -- no upstream or already up to date
      end

      git(root, { "status", "--porcelain", "--untracked-files=no" }, function(status)
        if status.code ~= 0 then
          return
        end
        if vim.trim(status.stdout or "") ~= "" then
          notify(
            ("%d new config commit(s) available, but the repo has local changes.\n"
              .. "Skipping auto-update – commit or discard them first."):format(behind),
            levels.WARN
          )
          return
        end

        git(root, { "pull", "--ff-only", "--quiet" }, function(pull)
          if pull.code == 0 then
            notify(("Config updated (%d commit%s).%s"):format(behind, behind == 1 and "" or "s", M.hint))
          else
            notify("Config update failed:\n" .. vim.trim(pull.stderr or ""), levels.ERROR)
          end
        end)
      end)
    end)
  end)
end

-- Plugin update (lazy.nvim) -----------------------------------------------

function M.update_plugins()
  if not due("plugins", M.opts.interval) then
    return
  end
  local ok, lazy = pcall(require, "lazy")
  if not ok then
    return
  end

  local lockfile = require("lazy.core.config").options.lockfile
  local before = read_file(lockfile)

  vim.api.nvim_create_autocmd("User", {
    pattern = "LazyUpdate",
    once = true,
    callback = function()
      vim.schedule(function()
        if read_file(lockfile) ~= before then
          notify("Plugins updated." .. M.hint)
        end
      end)
    end,
  })

  lazy.update({ show = false })
end

-- Entry point -------------------------------------------------------------

function M.setup(opts)
  M.opts = vim.tbl_extend("force", M.opts, opts or {})
  local root = M.opts.repo
  if not root or not uv.fs_stat(root .. "/.git") then
    return -- config is not inside a git repo: updater stays off
  end

  if vim.fn.exists(":restart") == 2 then
    M.hint = " Run :restart to apply."
  end

  if due("config", M.opts.interval) then
    vim.api.nvim_create_autocmd("VimEnter", {
      once = true,
      callback = function()
        vim.defer_fn(function()
          M.check_config(root)
        end, 500)
      end,
    })
  end
end

return M
