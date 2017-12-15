#!/bin/bash
export PATH="/usr/bin:/bin"

mgr='yaourt'

if hash yaourt 2>/dev/null; then
	break;
else
	mgr='pacman'
fi

echo "Updates have been downloaded. Do you wish to install them?"
echo "::WARNING::"
echo "Choosing not to install is very dangerous, as it may"
echo "result in partial upgrades. The primary reason for this"
echo "script to open the terminal is so the user can interactively"
echo "manage installation."
select yn in "Yes" "No"; do
    case $yn in
        Yes ) echo "Installing..."; $mgr -Su; break;;
        No ) exit;;
    esac
done
