#!/usr/bin/env sh

MAIN_SCRIPT_PATH=$(realpath "$0")
SRC_DIR_PATH=$(dirname "${MAIN_SCRIPT_PATH}")
LIB_DIR_PATH="${SRC_DIR_PATH}/lib"
UTILS_DIR_PATH="${LIB_DIR_PATH}/utils"

. "${UTILS_DIR_PATH}/logging.sh"
. "${UTILS_DIR_PATH}/validators.sh"

apply_hook_arg() {
  arg="$1"
  case "${arg}" in
    "--log-level"*)
      val=$(echo "${arg}" | cut -d ' ' -f 2)
      is_valid=$(validate_enum "--log-level" "${val}" "off,debug,info,warning,error")
      if [ "${is_valid}" = "true" ]; then
        GLOB_LOG_LEVEL="${val}"
      fi
      ;;
    *)
      log_warning "Unknown ${arg} argument has been passed as --hook-args"
      ;;
  esac
}
