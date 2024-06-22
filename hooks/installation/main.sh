#!/usr/bin/env sh
# shellcheck disable=SC2039,SC3020
set -eu

SCRIPT_PATH=$(realpath "$0")
INSTALLATION_FOLDER_PATH=$(dirname "${SCRIPT_PATH}")

if ! command -v grype &> /dev/null; then
  ${INSTALLATION_FOLDER_PATH}/install-standalone.sh
fi
