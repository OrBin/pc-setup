#!/bin/bash

timeout_period="${1}"
echo "Initializing IDEs for ${timeout_period}"
shift

for ide_name in  "$@"; do
  echo "Initializing ${ide_name}"
  (timeout "${timeout_period}" "${ide_name}") &
done

echo "Waiting..."
wait $(jobs -p) || true
echo "Done"