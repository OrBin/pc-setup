#!/bin/bash
set -e

UBUNTU_VERSION=impish

repo_root=$(git rev-parse --show-toplevel)
repo_name=$(basename "${repo_root}")
instance_name="${repo_name}-test"

multipass delete -p "${instance_name}" || true
multipass launch --name "${instance_name}" "${UBUNTU_VERSION}"
multipass mount "${repo_root}" "${instance_name}:/${repo_name}"
multipass exec "${instance_name}" -- bash -c "ANSIBLE_BECOME_ASK_PASS=0 /${repo_name}/setup.sh"