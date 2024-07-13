#!/usr/bin/env sh

ROOT_DIR=$(dirname $(realpath "$0"))

# Install dependencies
${ROOT_DIR}/scripts/bpkg-install-packages.sh
# Run hook
${ROOT_DIR}/src/main.sh "$@"
