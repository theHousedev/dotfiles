# Personal Config Repo

This is how I manage a 1:1 config setup across multiple machines. If there's a utility, shell script, or user-scoped custom config file you don't want to rebuild for every new work environment, then `stow` is the tool you're after.

Feel free[^1] to out [GNU stow](https://www.gnu.org/software/stow/) for yourself, and don't forget to read [the docs](https://www.gnu.org/software/stow/manual/stow.html#Introduction).

[^1]: FOSS forever*

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



That's it, pretty hassle free. When you make any config changes, commit and push them to your own remote - then enjoy pulling it down from anywhere you need a familiar and comfortable workspace.

> [!WARNING]
> If you want to copy these configs, you'll need access to:
> - `bash`
> - `nvim`
> - `tmux`
> - `lsd`
> - `pydf`
> 
> In addition, many of my configs are hardcoded specific to my username, so this may break usability of certain features. I encourage you to just build your own configs and stow them yourself!
>
> (But feel free to take anything interesting you find here.)

# Config Details
I am mostly after tools that improve my (hobbyist, to be clear) workflow in a way that I feel is sensible. This includes a very [kickstart](https://github.com/nvim-lua/kickstart.nvim)-inspired modular Neovim config with some tweaks, a bit of a bash prompt overhaul with aliases, and my own `git` and `tmux` configs to keep things consistent.

The good news: It doesn't have to be limited to these items, and can be expanded to whatever configurations you desire.

## Bash Prompt
My basic bash prompt is just a multiline with coloring, and decorations that can be toggled.

Format: `Date:Time.Seconds Username(:PresentWorkingDir)(:GitBranch)`

![basic prompt](readme-assets/basic-prompt.jpg)

If I move into a `git` repo, the branch name will be displayed and color-coded based on the status of this branch with regard to commit history:

![git prompt](readme-assets/git-prompt.jpg)
Notice after committing that "main" turns blue like my username and pwd. There isn't much more to my prompt besides that `prompt` command to toggle the special characters, and a venv flag if needed.

## Aliases
I embrace a few common aliases, like:
> `..` → `cd ..`  
`...` → `cd ../..`  
`..l` → `cd .. && ls`  
`f` → `find . | grep`  
`h` → `history . | grep`

Some git shortcuts:
> `gp` → `git push`  
`gs` → `git status`  
`pg` → `git pull origin`  
`log` → `git log -10 --oneline --graph`  
`log20` → `git log -20 --oneline --graph`  
`log40` → `git log -40 --oneline --graph`

And the following add/commit function:
> `gac` → `git add commit . -m` 

Several other functions exist like `prompt`, and you'll also find specific Neovim aliases to rapidly get into either nvim or bash configs.
