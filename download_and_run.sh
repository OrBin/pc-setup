#!/bin/bash

wget --no-cache https://codeload.github.com/OrBin/pc-setup/tar.gz/refs/heads/gnome-work-temp -O /tmp/pc-setup.tar.gz  # TODO revert
rm -rf /tmp/pc-setup/ && mkdir -p /tmp/pc-setup/
tar -xvzf /tmp/pc-setup.tar.gz -C /tmp/pc-setup/ --strip-components=1
rm /tmp/pc-setup.tar.gz

/tmp/pc-setup/setup.sh
