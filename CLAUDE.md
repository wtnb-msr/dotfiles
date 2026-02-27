# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

Personal dotfiles repository managing zsh, vim, tmux, and git configurations. Deployed to `$HOME` via symlinks.

## Setup

```sh
./install.sh  # Symlinks all dotfiles (.*) to $HOME, skipping .git and .DS_Store
```

## Architecture

### Zsh (.zshrc → .zsh/)

`.zshrc` sources two directories in order:

1. **`.zsh/init/*.sh`** — Core shell setup (alias, config, path, prompt, completion, brew)
2. **`.zsh/opt/*.sh`** — Optional/tool-specific configs (bun, claude, claude-tmux)

Files are sourced alphabetically within each directory. To add new configuration, create a `.sh` file in the appropriate directory.

### Vim (.vim/vimrc → .vim/init/, .vim/plugins/)

`.vim/vimrc` uses `runtime!` to load:

1. **`.vim/init/*.vim`** — Editor settings (basic, keybind, template)
2. **`.vim/plugins/*.vim`** — Plugin configurations

New file templates are in `.vim/template/` (loaded by `init/template.vim` on `BufNewFile`).

### Tmux (.tmux.conf)

- Prefix: `Ctrl-t`
- Vim-style pane navigation (`h`/`j`/`k`/`l`)
- `|` and `-` for splits
- Vi copy mode with pbcopy integration
- Plugins via TPM: tmux-open, tmux-resurrect, tmux-sensible, tmux-yank

### Git (.gitconfig)

- Includes `~/.gitconfig.local` for machine-specific settings (credentials, etc.)
- Key aliases: `st`, `co`, `ci`, `br`, `tr` (log tree), `sync` (rebase+push+gc)

## Conventions

- Zsh scripts use `.sh` extension
- Vim scripts use `.vim` extension
- Indentation: 2 spaces (shell, vim configs)
- Locale: ja_JP.UTF-8
- macOS (Apple Silicon) assumed — Homebrew at `/opt/homebrew/`
