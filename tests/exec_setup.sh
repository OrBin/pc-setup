#!/bin/bash
set -e

TESTS_DIR=$(dirname "${BASH_SOURCE}")

source "${TESTS_DIR}/compute_env.sh"

computer_type_flags=()

if [ -n "${COMPUTER_TYPE}" ]; then
  computer_type_flags=("--extra-vars" "computer_type=${COMPUTER_TYPE}")
fi

setup_command="ANSIBLE_BECOME_ASK_PASS=0 /${REPO_NAME}/setup.sh --extra-vars \"@/${REPO_NAME}/tests/test_vars.yml\" ${computer_type_flags[@]}"
multipass exec "${INSTANCE_NAME}" -- bash -c "${setup_command}"
