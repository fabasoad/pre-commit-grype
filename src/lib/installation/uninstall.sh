#!/usr/bin/env sh

#MAIN_SCRIPT_PATH=$(realpath "$0")
#SRC_DIR_PATH=$(dirname "${MAIN_SCRIPT_PATH}")
#LIB_DIR_PATH="${SRC_DIR_PATH}/lib"
#UTILS_DIR_PATH="${LIB_DIR_PATH}/utils"
#
#. "${UTILS_DIR_PATH}/logging.sh"

try_uninstall() {
  bin_dir="$1"
  to_uninstall="$2"
  if [ "${to_uninstall}" = "true" ]; then
    log_debug "Uninstalling ${bin_dir} directory started"
    rm -rf "${bin_dir}"
    log_debug "Uninstalling ${bin_dir} directory completed"
  fi
}
