#!/bin/bash
wget -i urls.txt
read -p "Press enter to continue"
#sleep 3
cat checksums.sha256
echo "Now compare with:"
sha256sum program-latest-amd64.deb
