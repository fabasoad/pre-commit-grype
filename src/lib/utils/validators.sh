#!/usr/bin/env sh

MAIN_SCRIPT_PATH=$(realpath "$0")
SRC_DIR_PATH=$(dirname "${MAIN_SCRIPT_PATH}")
LIB_DIR_PATH="${SRC_DIR_PATH}/lib"
UTILS_DIR_PATH="${LIB_DIR_PATH}/utils"

. "${UTILS_DIR_PATH}/logging.sh"

validate_enum() {
  param_key="$1"
  param_val="$2"
  enum_opts="$3,"
  log_level="${4:warning}"
  case ",${enum_opts}" in
    *",${param_val},"*)
      echo "true"
      ;;
    *)
      log_${log_level} "\"${param_key}\" parameter is invalid. Possible values: $(echo "${enum_opts%,}" | sed 's/,/, /g')."
      echo "false"
      ;;
  esac
}

validate_log_level() {
  validate_enum "--log-level" "$1" "off,debug,info,warning,error"
}
