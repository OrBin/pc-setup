#!/bin/bash

REPO_ROOT=$(dirname "${BASH_SOURCE}")

install_pip() {
  wget -qO- https://bootstrap.pypa.io/get-pip.py | sudo python3 -
}

sudo python3 -m pip > /dev/null 2>&1 || install_pip
sudo python3 -m pip install ansible
ansible-galaxy install -r "${REPO_ROOT}/requirements.yml"
ANSIBLE_BECOME_ASK_PASS=${ANSIBLE_BECOME_ASK_PASS:-1} ansible-playbook -i "${REPO_ROOT}/inventory.ini" "${[@]}" "${REPO_ROOT}/main.yml"