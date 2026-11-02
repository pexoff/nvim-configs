# nvim-configs

My Neovim configs for all my Linux machines – with automatic updates.

| Profile  | Purpose                                  |
|----------|------------------------------------------|
| `client` | Laptop, tablet, desktop – full config    |
| `server` | Servers – minimal, work in progress      |

## Installation

```bash
curl -fsSL https://raw.githubusercontent.com/pexoff/nvim-configs/main/install.sh | bash -s -- client
```

Or manually:

```bash
git clone https://github.com/pexoff/nvim-configs.git ~/.local/share/nvim-configs
~/.local/share/nvim-configs/install.sh client
```

The script clones the repo to `~/.local/share/nvim-configs`, backs up an
existing `~/.config/nvim` and creates a symlink
`~/.config/nvim → nvim-configs/<profile>`.

To switch profiles, simply run `install.sh` again with the other profile.

## How the auto-update works

On startup, `shared/lua/nvim_configs/updater.lua` checks in the background
(at most once per hour):

1. `git fetch` – are there new commits?
2. No → nothing happens.
3. Yes → `git pull --ff-only`, then a notification. Run `:restart` to apply.

Safety nets:

- Local changes in the repo → no pull, just a warning.
- Offline → silently gives up.
- Fast-forward only → nothing is ever overwritten or merged.

With the `client` profile, lazy.nvim additionally updates the plugins in the
background (also at most once per hour). The lockfile is kept per device at
`~/.local/share/nvim/lazy-lock.json` and is not part of the repo.

## Dependencies (client profile)

| What                    | Arch                               | Fedora                     |
|-------------------------|------------------------------------|----------------------------|
| Neovim ≥ 0.10, Git      | `neovim git`                       | `neovim git`               |
| Nerd Font (icons)       | `ttf-jetbrains-mono-nerd`          | manually, see Nerd Fonts   |
| Telescope live_grep     | `ripgrep`                          | `ripgrep`                  |
| `:LazyGit`              | `lazygit`                          | COPR `dejan/lazygit`       |
| Formatter (conform)     | `ast-grep`                         | `npm i -g @ast-grep/cli`   |
| Treesitter / plugins    | `base-devel`                       | `gcc make`                 |

## Structure

```
nvim-configs/
├── client/            client profile
│   ├── init.lua
│   └── lua/
│       ├── core/      options, keymaps, lazy.nvim setup
│       └── plugins/   plugin specs, grouped by topic
├── server/            server profile
├── shared/            shared modules (updater)
└── install.sh
```

## On machines where I edit the config

The install script clones via HTTPS (read-only). Switch to SSH to push:

```bash
git -C ~/.local/share/nvim-configs remote set-url origin git@github.com:pexoff/nvim-configs.git
```

this is a test to verify auto config load and git pull on neovim start.
