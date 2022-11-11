#!/bin/bash

wget https://codeload.github.com/OrBin/pc-setup/tar.gz/refs/heads/master -O /tmp/pc-setup.tar.gz
rm -rf /tmp/pc-setup/ && mkdir -p /tmp/pc-setup/
tar -xvzf /tmp/pc-setup.tar.gz -C /tmp/pc-setup/ --strip-components=1
rm /tmp/pc-setup.tar.gz

/tmp/pc-setup/setup.sh
