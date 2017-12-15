#!/bin/bash

echo "Updates have been downloaded. Do you wish to install them?"
echo "::WARNING::"
echo "Choosing not to install is very dangerous, as it may"
echo "result in partial upgrades."
select yn in "Yes" "No"; do
    case $yn in
        Yes ) echo "Installing..."; yaourt -Su; break;;
        No ) exit;;
    esac
done