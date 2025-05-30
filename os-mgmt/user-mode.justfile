

upgrade-flatpak:
    if flatpak remotes | grep -q system
    then
        flatpak update -y
    fi

post-flatpak-upgrade-status:
    updates=$(flatpak remote-ls --updates)
    if [[ -n "$updates" ]]
    then
        echo "Updates available:"
        dbus-send --session \
	        --dest=org.freedesktop.Notifications \
	        --type=method_call \
	        --print-reply \
	        /org/freedesktop/Notifications \
	        org.freedesktop.Notifications.Notify \
	        string:"Package Manager" \
	        uint32:0 \
	        string:"Update Status" \
	        string:"pending"
    else
        echo "No updates."
    fi
   

upgrade-brew:
    if [[ -O /var/home/linuxbrew/.linuxbrew/bin/brew ]]
    then
        /var/home/linuxbrew/.linuxbrew/bin/brew upgrade
    fi

post-brew-upgrade-status:
    /var/home/linuxbrew/.linuxbrew/bin/brew upgrade --dry-run
    if [[ -n "$(/var/home/linuxbrew/.linuxbrew/bin/brew outdated)" ]]
    then
        then
            dbus-send --session \
	            --dest=org.freedesktop.Notifications \
	            --type=method_call \
	            --print-reply \
	            /org/freedesktop/Notifications \
	            org.freedesktop.Notifications.Notify \
	            string:"Package Manager" \
	            uint32:0 \
	            string:"Update Status" \
	            string:"pending"
        fi
    fi

   
upgrade-pixi:
    if command -v pixi &> /dev/null && [ -x "$(command -v pixi)" ]
    then
        pixi global update 
    fi

post-pixi-upgrade-status:
    if [[ pixi global update --dry-run --json | /usr/sbin/jq -e ".environment | .before.md5 == .after.md5" ]]
    then
        echo "no pixi updates required"
    else
        dbus-send --session \
    	    --dest=org.freedesktop.Notifications \
	        --type=method_call \
	        --print-reply \
	        /org/freedesktop/Notifications \
	        org.freedesktop.Notifications.Notify \
	        string:"Package Manager" \
	        uint32:0 \
	        string:"Update Status" \
	        string:"pending"
    fi

