#!/bin/bash
set -e

TESTS_DIR=$(dirname "${BASH_SOURCE}")

source "${TESTS_DIR}/compute_env.sh"

cpu_flags=()

if [ "$(systemd-detect-virt)" != "none" ]; then
  cpu_flags=("--cpus" "$(nproc)")
fi

"${TESTS_DIR}/validate_multipass.sh"

multipass delete -p "${INSTANCE_NAME}" || true
multipass launch --name "${INSTANCE_NAME}" --disk 15G "${cpu_flags[@]}" "${UBUNTU_VERSION}"
multipass mount "${REPO_ROOT}" "${INSTANCE_NAME}:/${REPO_NAME}"
"${TESTS_DIR}/exec_setup.sh"