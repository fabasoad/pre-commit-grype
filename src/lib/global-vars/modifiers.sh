#!/usr/bin/env sh

#MAIN_SCRIPT_PATH=$(realpath "$0")
#SRC_DIR_PATH=$(dirname "${MAIN_SCRIPT_PATH}")
#LIB_DIR_PATH="${SRC_DIR_PATH}/lib"
#GLOBAL_VARS_DIR_PATH="${LIB_DIR_PATH}/global-vars"
#UTILS_DIR_PATH="${LIB_DIR_PATH}/utils"
#
#. "${GLOBAL_VARS_DIR_PATH}/default.sh"
#. "${UTILS_DIR_PATH}/validators.sh"

PRE_COMMIT_GRYPE_LOG_LEVEL_DEFAULT_VAL="info"

get_global_log_level_default_value() {
  echo "${PRE_COMMIT_GRYPE_LOG_LEVEL_DEFAULT_VAL}"
}

get_global_log_level() {
  echo "${PRE_COMMIT_GRYPE_LOG_LEVEL:-${PRE_COMMIT_GRYPE_LOG_LEVEL_DEFAULT_VAL}}"
}

set_global_log_level() {
  log_level="$1"
  is_valid=$(validate_log_level "${log_level}")
  if [ "${is_valid}" = "true" ]; then
    export PRE_COMMIT_GRYPE_LOG_LEVEL="${log_level}"
  fi
}

reset_global_log_level() {
  set_global_log_level "${PRE_COMMIT_GRYPE_LOG_LEVEL_DEFAULT_VAL}"
}
