#!/bin/bash

mgr='yaourt'

depget() {
	echo "::Checking dependencies."
    if hash yaourt 2>/dev/null; then
        echo "command yaourt found."
    else
        echo "Yaourt not found. I won't be able to access the AUR without it."
		echo "::Install yaourt? (Y/N)"
		select yn in "Yes" "No"; do
			case $yn in
		    		Yes ) echo "Installing..."; echo "TODO"; break;;
		    		No ) echo "Falling back to pacman."; mgr='pacman'; break;;
			esac
		done
    fi
    if hash crontab 2>/dev/null; then
    	echo "command crontab found."
    else
    	echo "Crontab not found; Installing..."
    	$mgr -S cronie
    fi
    if hash wget 2>/dev/null; then
    	echo "command wget found."
    else
    	echo "wget not found; Installing..."
    	$mgr -S wget
    fi

}

depget

if [ ! -d ./src ]; then
	echo "::Install script must be run from the updateutil folder."
	echo "Please cd to the folder."; exit 1;
fi

echo "::Installing..."

if [ ! -d ~/scripts ]; then
  # Control will enter here if directory doesn't exist.
  echo "Script directory not found. Creating..."
  mkdir ~/scripts
fi

echo "Copying files to install location..."
cp ./src/installupdates.sh ~/scripts/installupdates.sh
cp ./src/updatepackages.sh ~/scripts/updatepackages.sh

echo "::Writing to crontab..."
echo "Enter how often to download packages in hours: "
read hours
sudo crontab -l > usercron
echo "PATH='/usr/bin:/bin:/usr/local/bin:/usr/sbin:/sbin'" >> usercron
echo "0 */$hours * * * . sudo -u root ~/scripts/updatepackages.sh # JOB_ID_1" >> usercron
sudo crontab usercron
rm usercron
echo "Installation complete."
