#!/usr/bin/env sh

MAIN_SCRIPT_PATH=$(realpath "$0")
SRC_DIR_PATH=$(dirname "${MAIN_SCRIPT_PATH}")
LIB_DIR_PATH="${SRC_DIR_PATH}/lib"
GLOBAL_VARS_DIR_PATH="${LIB_DIR_PATH}/global-vars"

. "${GLOBAL_VARS_DIR_PATH}/default.sh"

set_global_log_level() {
  export PRE_COMMIT_GRYPE_LOG_LEVEL="$1"
}

reset_global_log_level() {
  set_log_level "${PRE_COMMIT_GRYPE_LOG_LEVEL_DEFAULT_VAL}"
}
