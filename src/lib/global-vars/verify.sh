#!/usr/bin/env sh

#MAIN_SCRIPT_PATH=$(realpath "$0")
#SRC_DIR_PATH=$(dirname "${MAIN_SCRIPT_PATH}")
#LIB_DIR_PATH="${SRC_DIR_PATH}/lib"
#GLOBAL_VARS_DIR_PATH="${LIB_DIR_PATH}/global-vars"
#UTILS_DIR_PATH="${LIB_DIR_PATH}/utils"
#
#. "${GLOBAL_VARS_DIR_PATH}/default.sh"
#. "${GLOBAL_VARS_DIR_PATH}/modifiers.sh"
#. "${UTILS_DIR_PATH}/logging.sh"
#. "${UTILS_DIR_PATH}/validators.sh"

_verify_log_level() {
  env_var_name="PRE_COMMIT_GRYPE_LOG_LEVEL"
  env_var_opts="off,debug,info,warning,error"
  is_valid=$(validate_enum "${env_var_name}" "$(get_global_log_level)" "${env_var_opts}" "off")
  if [ "${is_valid}" = "false" ]; then
    msg="\"${env_var_name}\" environment variable is invalid. Possible values:"
    msg="${msg} $(echo "${env_var_opts%,}" | sed 's/,/, /g'). Setting back"
    msg="${msg} to default value: \"$(get_global_log_level_default_value)\"."
    log_warning "${msg}"
    reset_global_log_level
  fi
}

verify_global_vars() {
  _verify_log_level
}
