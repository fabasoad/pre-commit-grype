#!/usr/bin/env sh

SCRIPT_PATH=$(realpath "$0")
HOOKS_DIR_PATH=$(dirname "${SCRIPT_PATH}")
SRC_DIR_PATH=$(dirname "${HOOKS_DIR_PATH}")
UTILS_DIR_PATH="${SRC_DIR_PATH}/utils"

. "${UTILS_DIR_PATH}/logging.sh"

cleanup() {
  log_debug "Removing ${bin_dir} directory started"
  bin_dir="$1"
  rm -rf "${bin_dir}"
  log_debug "Removing ${bin_dir} directory completed"
}
