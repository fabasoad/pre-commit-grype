#!/usr/bin/env sh

MAIN_SCRIPT_PATH=$(realpath "$0")
SRC_DIR_PATH=$(dirname "${MAIN_SCRIPT_PATH}")
LIB_DIR_PATH="${SRC_DIR_PATH}/lib"
GLOBAL_VARS_DIR_PATH="${LIB_DIR_PATH}/global-vars"
UTILS_DIR_PATH="${LIB_DIR_PATH}/utils"

. "${GLOBAL_VARS_DIR_PATH}/default.sh"
. "${GLOBAL_VARS_DIR_PATH}/modifiers.sh"
. "${UTILS_DIR_PATH}/logging.sh"
. "${UTILS_DIR_PATH}/validators.sh"

_verify_log_level() {
  if [ -z "${PRE_COMMIT_GRYPE_LOG_LEVEL}" ]; then
    reset_global_log_level
  else
    opts="off,debug,info,warning,error"
    is_valid=$(validate_enum "PRE_COMMIT_GRYPE_LOG_LEVEL" "${PRE_COMMIT_GRYPE_LOG_LEVEL}" "${opts}" "off")
    if [ "${is_valid}" = "false" ]; then
      msg="\"PRE_COMMIT_GRYPE_LOG_LEVEL\" environment variable is invalid. Possible"
      msg="${msg} values: $(echo "${opts%,}" | sed 's/,/, /g'). Setting back"
      msg="${msg} to default value: \"${PRE_COMMIT_GRYPE_LOG_LEVEL_DEFAULT_VAL}\"."
      log_warning "${msg}"
      reset_global_log_level
    fi
  fi
}

verify_global_vars() {
  _verify_log_level
}
