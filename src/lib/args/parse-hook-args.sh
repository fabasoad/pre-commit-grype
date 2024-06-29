#!/usr/bin/env sh

MAIN_SCRIPT_PATH=$(realpath "$0")
SRC_DIR_PATH=$(dirname "${MAIN_SCRIPT_PATH}")
LIB_DIR_PATH="${SRC_DIR_PATH}/lib"
UTILS_DIR_PATH="${LIB_DIR_PATH}/utils"

. "${UTILS_DIR_PATH}/logging.sh"
. "${UTILS_DIR_PATH}/validators.sh"

_set_log_level() {
  val="$1"
  is_valid=$(validate_enum "--log-level" "${val}" "off,debug,info,warning,error")
  if [ "${is_valid}" = "true" ]; then
    GLOB_LOG_LEVEL="${val}"
  fi
}

parse_hook_args() {
  if [ -n "$@" ]; then
    log_info "Pre-commit hook arguments: $@"
    while [ $# -gt 0 ]; do
      case "$1" in
        --log-level=*)
          _set_log_level "${1#*=}"
          ;;
        --log-level)
          shift
          _set_log_level "$1"
          ;;
        *)
          log_warning "Unknown $1 argument has been passed as --hook-args"
          ;;
      esac
      shift
    done
  fi
}
