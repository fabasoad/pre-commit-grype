#!/usr/bin/env sh

root_path=$(dirname $(realpath "$0"))
# Install dependencies
${root_path}/scripts/bpkg-install-packages.sh
# Run hook
${root_path}/src/main.sh "$@"
