#!/bin/bash

timeout_period="2s"
echo "Initializing IDEs for ${timeout_period}"

for ide_name in  "$@"; do
  echo "Initializing ${ide_name}"
  (timeout "${timeout_period}" "${ide_name}" "$(mktemp)") &
done

echo "Waiting..."
wait $(jobs -p) || true
echo "Done"
