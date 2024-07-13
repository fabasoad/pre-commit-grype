#!/usr/bin/env sh

# Install dependencies
scripts/bpkg-install-packages.sh
# Run hook
src/main.sh "$@"
