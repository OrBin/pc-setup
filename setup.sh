#!/bin/bash

set -e
REPO_ROOT=$(dirname "${BASH_SOURCE}")

install_pip() {
  sudo apt-get install python3-distutils -y
  wget -qO- https://bootstrap.pypa.io/get-pip.py | sudo python3 -
}

sudo python3 -m pip > /dev/null 2>&1 || install_pip
sudo python3 -m pip install ansible~=5.1.0 jq~=1.2.1 lxml~=4.7.1

galaxy_requirements_installed="${REPO_ROOT}/.local_state/ansible_galaxy_requirements_installed"
galaxy_requirements_spec="${REPO_ROOT}/requirements.yml"

if [ ! -f $galaxy_requirements_installed ] || [ $(stat --format '%Y' $galaxy_requirements_installed) -lt $(stat --format '%Y' $galaxy_requirements_spec) ]; then
  ansible-galaxy install -r $galaxy_requirements_spec --force
  mkdir -p $(dirname $galaxy_requirements_installed)
  touch $galaxy_requirements_installed
fi

time ANSIBLE_STDOUT_CALLBACK=debug ANSIBLE_BECOME_ASK_PASS=${ANSIBLE_BECOME_ASK_PASS:-1} ansible-playbook -i "${REPO_ROOT}/inventory.ini" "$@" "${REPO_ROOT}/main.yml"
