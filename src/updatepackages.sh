#!/bin/bash
export PATH="/usr/bin:/bin"

echo "Attempting to connect..."
wget -q --spider http://google.com

if [ $? -eq 0 ]; then
    echo "Connection confirmed."
    yaourt -Syuw --noconfirm
    tilix -e scripts/installupdates.sh
else
    echo "Offline"
fi