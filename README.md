## Dotfiles config for Fedora Sway Atomic
Hello this is my sway atomic config(dual monitors).
## Instructions
1. Clone the repo 
2. run ./dotfiles_config
3. insert password when prompted(needed for wallpaper container and rpm-ostree for vim and tmux)
4. after you run the script in ~/Pictures/Wallpapers/sddm place a wallpaper of choice, rename the wallpaper to "sddm.png"
5. for normal wallpapers place them in the ~/Pictures/Wallpapers dir
## What does the script do 
1. It installs the dotfiles config
2. It sets up a wallpaper container in podman(rootless) for swww and ImageMagick
3. Removes nano as default editor and adds vim
5. It layers tmux to the ostree
> NOTE
> This config was made for Fedora Sway Atomic, the script will not work on other systems out of the box
