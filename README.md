# Personal Config Repo

This is how I manage a 1:1 config setup across multiple machines. If there's a utility, shell script, or user-scoped custom config file you don't want to rebuild for every new work environment, then `stow` is the tool you're after.

Feel free* to out [GNU stow](https://www.gnu.org/software/stow/) for yourself, and don't forget to read [the docs](https://www.gnu.org/software/stow/manual/stow.html#Introduction).

**FOSS forever*

### Installation:
- `sudo apt install stow`
- `pacman -S stow` (Arch btw)

### Setup:
1) Create a dedicated config dir in your home (mine is `~/.dotfiles/`)
2) `mv` relevant config files/dirs into `.dotfiles/`
    - Note: I've placed the files inside their own respective "package" dirs, i.e.
        - `~/.dotfiles/nvim/`
        - `~/.dotfiles/bash/`
        - etc.
3) `cd ~/.dotfiles/` (or whatever you named it)
4) `stow .` to set up all symlinks to the new locations



That's it, pretty hassle free. If you want to copy this repo directly, you'll need access to `nvim`, `tmux`, and `bash`. If you make changes, commit and push them to your own remote - then enjoy pulling it down from anywhere you may need a familiar workspace.

# Config Details
I am mostly after tools that improve my (hobbyist, to be clear) workflow in a way that I feel is sensible. This includes a very `kickstart`-inspired modular Neovim config with some tweaks, a bit of a bash prompt overhaul, and my own basic `git` and `tmux` config to keep things consistent.