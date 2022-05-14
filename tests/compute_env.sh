export UBUNTU_VERSION=jammy

export REPO_ROOT=$(git rev-parse --show-toplevel)
export REPO_NAME=$(basename "${REPO_ROOT}")
export INSTANCE_NAME="${REPO_NAME}-test"
