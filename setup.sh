#!/bin/bash

REPO_ROOT=$(dirname "${BASH_SOURCE}")

install_pip() {
  wget -qO- https://bootstrap.pypa.io/get-pip.py | python3 -
}

python3 -m pip > /dev/null 2>&1 || install_pip
python3 -m pip install ansible
ansible-galaxy install -r "${REPO_ROOT}/requirements.yml"
ansible-playbook "${REPO_ROOT}/or-setup.yml" --ask-become-pass