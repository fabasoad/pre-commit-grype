#!/usr/bin/env sh

MAIN_SCRIPT_PATH=$(realpath "$0")
SRC_DIR_PATH=$(dirname "${MAIN_SCRIPT_PATH}")
LIB_DIR_PATH="${SRC_DIR_PATH}/lib"
UTILS_DIR_PATH="${LIB_DIR_PATH}/utils"

. "${UTILS_DIR_PATH}/logging.sh"
. "${UTILS_DIR_PATH}/validators.sh"

_set_log_level() {
  log_level="$1"
  is_valid=$(validate_log_level "${log_level}")
  if [ "${is_valid}" = "true" ]; then
    GLOB_LOG_LEVEL="${log_level}"
  fi
}

_set_param() {
  param_name="$1"
  args_str="$2"
  delimiter="$3"
  args_str=$(echo "${args_str}" | cut -d "${delimiter}" -f 2-)
  param_val=$(echo "${args_str}" | cut -d ' ' -f 1 | sed 's/^ *//')
  args_str=$(echo "${args_str}" | cut -d ' ' -f 2- | sed 's/^ *//')
  _set_${param_name} "${param_val}"
  if [ "${param_val}" = "${args_str}" ]; then
    echo ""
  else
    echo "${args_str}"
  fi
}

parse_hook_args() {
  args_str="$1"
  if [ -n "${args_str}" ]; then
    log_info "Pre-commit hook arguments: ${args_str}"
    while [ ${#args_str} -gt 0 ]; do
      case "${args_str}" in
        "--log-level="*)
          args_str=$(_set_param "log_level" "${args_str}" "=")
          ;;
        "--log-level "*)
          args_str=$(_set_param "log_level" "${args_str}" " ")
          ;;
        *)
          log_warning "Unknown ${args_str} argument has been passed as --hook-args"
          ;;
      esac
      shift
    done
  fi
}
