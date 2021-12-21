export UBUNTU_VERSION=impish

export REPO_ROOT=$(git rev-parse --show-toplevel)
export REPO_NAME=$(basename "${REPO_ROOT}")
export INSTANCE_NAME="${REPO_NAME}-test"
