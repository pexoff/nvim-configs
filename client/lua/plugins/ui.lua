return {
  -- File tree
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("nvim-tree").setup({
        view = {
          width = 35,
          relativenumber = true,
          number = true,
        },
        renderer = {
          indent_markers = { enable = true },
          icons = {
            glyphs = {
              folder = {
                arrow_closed = "",
                arrow_open = "",
              },
            },
          },
        },
        actions = {
          open_file = {
            window_picker = { enable = false },
          },
        },
        filters = {
          custom = { ".DS_Store" },
        },
        git = {
          ignore = false,
        },
      })
    end,
  },

  -- Status line
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      options = {
        theme = "vscode",
      },
    },
  },

  -- Tabs
  { "nanozuki/tabby.nvim" },

  -- Nicer input and select windows
  { "stevearc/dressing.nvim" },

  -- Indent guides
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    opts = {},
  },

  -- Scrollbar (pinned to v1, v2 breaks this config)
  {
    "petertriho/nvim-scrollbar",
    branch = "v1",
    dependencies = {
      "kevinhwang91/nvim-hlslens",
      "lewis6991/gitsigns.nvim",
    },
    config = function()
      require("scrollbar").setup()
      require("scrollbar.handlers.search").setup({})
      require("scrollbar.handlers.gitsigns").setup()
    end,
  },

  -- Clock and focus timer
  {
    "rushjs1/clock.nvim",
    opts = {
      title_pos = "left", -- "left", "right" or "center"
      window_pos = "tr", -- "tr" (top right) or "center"
      timeout = true,
      timeout_duration = 30000,
      timer_opts = {
        timer_duration = 600, -- 10 minutes (in seconds)
        timer_completion_duration = 10000, -- 10 seconds (in milliseconds)
        timer_title = "Lock in for",
        timer_duration_selections = {
          60, 300, 600, 900, 1200, 1500, 1800,
          2100, 2400, 2700, 3000, 3300,
        },
      },
    },
  },

  -- Save sessions per directory
  {
    "rmagatti/auto-session",
    lazy = false,
    opts = {
      suppressed_dirs = { "~/", "~/Downloads", "/" },
    },
  },

  -- Show CSS colors inline
  { "ap/vim-css-color" },
}
