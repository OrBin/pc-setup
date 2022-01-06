#!/bin/bash
set -e

TESTS_DIR=$(dirname "${BASH_SOURCE}")

source "${TESTS_DIR}/compute_env.sh"

multipass exec "${INSTANCE_NAME}" -- bash -c "ANSIBLE_BECOME_ASK_PASS=0 /${REPO_NAME}/setup.sh --extra-vars \"@/${REPO_NAME}/tests/test_vars.yml\""