#!/bin/bash

dummy_id=$(echo $RANDOM | md5sum | cut -d ' ' -f 1)

if multipass launch $dummy_id 2>&1 | grep -q 'launch failed: Remote "" is unknown or unreachable.'; then
  sudo snap restart multipass.multipassd
fi