#!/bin/bash

set -e
REPO_ROOT=$(dirname "${BASH_SOURCE}")

install_pip() {
  sudo apt-get install python3-distutils -y
  wget -qO- https://bootstrap.pypa.io/get-pip.py | sudo python3 -
}

sudo python3 -m pip > /dev/null 2>&1 || (echo "pip is missing, installing" && install_pip)
sudo python3 -m pip install --root-user-action=ignore -r requirements.txt

galaxy_requirements_installed="${HOME}/.config/pc-setup/ansible_galaxy_requirements_installed"
galaxy_requirements_spec="${REPO_ROOT}/requirements.yml"

if [ ! -f $galaxy_requirements_installed ] || [ $(stat --format '%Y' $galaxy_requirements_installed) -lt $(stat --format '%Y' $galaxy_requirements_spec) ]; then
  echo "Installing ${galaxy_requirements_spec} using ansible-galaxy"
  ansible-galaxy install -r $galaxy_requirements_spec --force
  mkdir -p $(dirname $galaxy_requirements_installed)
  touch $galaxy_requirements_installed
else
    echo "Requirements are already installed, skipping"
fi

time \
  ANSIBLE_STDOUT_CALLBACK=debug \
  ANSIBLE_BECOME_ASK_PASS=${ANSIBLE_BECOME_ASK_PASS:-1} \
  PATH="/home/linuxbrew/.linuxbrew/bin:/home/linuxbrew/.linuxbrew/sbin:${PATH}" \
  ansible-playbook \
  -i "${REPO_ROOT}/inventory.ini" \
  "$@" \
  "${REPO_ROOT}/main.yml"