#!/bin/bash

set -e
REPO_ROOT=$(dirname "${BASH_SOURCE}")

get_password() {
  stty -echo
  printf "Enter password: " >&2
  read password
  stty echo
  printf "\n" >&2
  echo "${password}"
}

install_pip() {
  sudo apt-get update
  sudo apt-get install python3-distutils -y
  wget -qO- https://bootstrap.pypa.io/get-pip.py | sudo python3 -
}

password=$(get_password)
sudo -S -k true <<< "${password}"  # Calling sudo once with the password, to validate
sudo -S true <<< "${password}"  # Calling sudo once again, to make it remember the permissions (which -k had reset before)

sudo python3 -m pip > /dev/null 2>&1 || (echo "pip is missing, installing" && install_pip)
sudo python3 -m pip install --root-user-action=ignore -r "${REPO_ROOT}/requirements.txt"

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
  PATH="/home/linuxbrew/.linuxbrew/bin:/home/linuxbrew/.linuxbrew/sbin:${PATH}" \
  ansible-playbook \
  -i "${REPO_ROOT}/inventory.ini" \
  -e "ansible_become_pass=${password}" \
  "$@" \
  "${REPO_ROOT}/main.yml"
