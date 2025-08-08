# Personal Configuration Repo

This is how I manage a 1:1 configuration setup across multiple machines.

Try out [GNU `stow`](https://www.gnu.org/software/stow/) for yourself, or [read the docs](https://www.gnu.org/software/stow/manual/stow.html#Introduction).

### Installation:
`sudo apt install stow` (Debian-esque distributions, Ubuntu, etc)
`pacman -S stow` (Arch linux)

### Setup:
1) Create a dedicated dir in your home (mine is `~/dotfiles/`)
2) `mv` relevant config files or entire config dirs into this new location
    - Note: I've placed the files inside their own respective "package" dirs, i.e.
        - `~/dotfiles/nvim/`
        - `~/dotfiles/bash/`
        - etc.
3) `cd` to the new location
4) `stow .` to set up the symlinks to the new locations.

That's it, pretty simple. If you want to copy this repo directly, you'll need access to `nvim`, `tmux`, and `bash`.
