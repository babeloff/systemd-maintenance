

upgrade-flatpak:
    if flatpak remotes | grep -q system
    then
        flatpak update -y
    fi

check-flatpak-upgrade-status:
   

upgrade-brew:
    if [[ -O /var/home/linuxbrew/.linuxbrew/bin/brew ]]
    then
        /var/home/linuxbrew/.linuxbrew/bin/brew upgrade
    fi

check-brew-upgrade-status:
    if [[ -O /var/home/linuxbrew/.linuxbrew/bin/brew ]]
    then
        /var/home/linuxbrew/.linuxbrew/bin/brew outdated 
    fi

   
upgrade-pixi:
    if command -v pixi &> /dev/null && [ -x "$(command -v pixi)" ]
    then
        pixi global update
    fi

check-pixi-upgrade-status:
