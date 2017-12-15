#!/bin/bash

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