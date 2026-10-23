Yes. There are several projects/scripts that aim to automate “same apps + same configs” across Arch/Omarchy machines.[learn.omacom+1](https://learn.omacom.io/2/the-omarchy-manual/65/dotfiles)

## Omarchy‑specific tools

-   **Omadot** (GitHub) – GNU Stow wrapper originally built for Omarchy.[[github](https://github.com/tomhayes/omadot)]​  
    Lets you keep all your Omarchy dotfiles in a repo and deploy/update them with one command per machine, instead of manually symlinking.
    
-   **Awesome Omarchy list** – Curated list that often links Omarchy‑oriented tooling (including Omadot and themes).[[github](https://github.com/aorumbayev/awesome-omarchy)]
    

These are the most “drop‑in” for Omarchy, since they assume the same layout described in the Omarchy Manual (dotfiles in ~/.config, Omarchy files in ~/.local/share/omarchy).[[learn.omacom](https://learn.omacom.io/2/the-omarchy-manual/65/dotfiles)]​

## General Arch/dotfiles automation

-   **aconfmgr** – Declarative system manager for Arch; tracks packages and selected config paths, then can “apply” that state to another machine.[[bbs.archlinux](https://bbs.archlinux.org/viewtopic.php?id=292368)]​
    
-   **pkgsync** – Simple script to sync installed pacman packages across Arch installs.[[github](https://github.com/moparisthebest/pkgsync)]​
    
-   **Dotfiles repos with install scripts** – Many users publish dotfiles plus `install.sh` / `bootstrap.sh` that: clone the repo, install a package list, and symlink configs (examples: `nickjj/dotfiles`, `joncrangle/.dotfiles`).[github+1](https://github.com/nickjj/dotfiles)
    

## How you might combine them

A practical Omarchy setup for you could be: Omadot for configs, pkgsync or an aconfmgr config for packages, and Syncthing or Git to move the repos between laptop and desktop.[bbs.archlinux+2](https://bbs.archlinux.org/viewtopic.php?id=292368)  
If you tell me whether you’d prefer “one command from scratch” (declarative, like aconfmgr) or “keep them in sync over time” (Omadot + pkgsync + Git/Syncthing), I can sketch an exact repo layout and command flow.