# Dotfiles

Personal dotfiles managed with [chezmoi](https://www.chezmoi.io/).

## Layout

```text
dotfiles/
  dot_config/          Files for ~/.config/
    tmux/tmux.conf     ~/.config/tmux/tmux.conf
```

chezmoi uses name prefixes to map source files to home directory paths:

- `dot_foo` becomes `~/.foo`
- `dot_config/` becomes `~/.config/`

## Usage

Add a file to management:

```sh
chezmoi add ~/.config/tmux/tmux.conf
```

Preview pending changes, then apply them to your home directory:

```sh
chezmoi diff
chezmoi apply
```

Show the source path for a managed file:

```sh
chezmoi source-path ~/.config/tmux/tmux.conf
```

## Not committed

- Secrets, tokens, or machine-specific credentials
