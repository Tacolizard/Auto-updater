#!/bin/bash
export PATH="/usr/bin:/bin"

mgr='yaourt'

if hash yaourt 2>/dev/null; then
	break;
else
	mgr='pacman'
fi

term='tilix'

if hash tilix 2>/dev/null; then
	break;
else
	echo "Tilix not found."; exit 1;
	#todo: find a way to get the default terminal emulator
fi

echo "Attempting to connect..."
wget -q --spider http://google.com

if [ $? -eq 0 ]; then
    echo "Connection confirmed."
    $mgr -Syuw --noconfirm
    $term -e ~/scripts/installupdates.sh
else
    echo "Connection failed."
fi
