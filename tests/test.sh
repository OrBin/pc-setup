#!/bin/bash
set -e

TESTS_DIR=$(dirname "${BASH_SOURCE}")

source "${TESTS_DIR}/compute_env.sh"

multipass delete -p "${INSTANCE_NAME}" || true
multipass launch --name "${INSTANCE_NAME}" "${UBUNTU_VERSION}"
multipass mount "${REPO_ROOT}" "${INSTANCE_NAME}:/${REPO_NAME}"
"${TESTS_DIR}/exec_setup.sh"