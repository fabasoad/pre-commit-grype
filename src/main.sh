#!/usr/bin/env sh

MAIN_SCRIPT_PATH=$(realpath "$0")
SRC_DIR_PATH=$(dirname "${MAIN_SCRIPT_PATH}")
HOOKS_DIR_PATH="${SRC_DIR_PATH}/hooks"
LIB_DIR_PATH="${SRC_DIR_PATH}/lib"
UTILS_DIR_PATH="${LIB_DIR_PATH}/utils"

. "${LIB_DIR_PATH}/default.sh"
. "${UTILS_DIR_PATH}/logging.sh"
. "${UTILS_DIR_PATH}/validators.sh"

cmd_grype_dir="grype-dir"
cmd_actual="$1"

. "${HOOKS_DIR_PATH}/${cmd_actual}.sh"
shift
if [ "${cmd_actual}" = "${cmd_grype_dir}" ]; then
  grype_dir "$(echo "$@" | sed 's/^ *//')"
else
  is_valid=$(validate_enum "hook" "${cmd_actual}" "${cmd_grype_dir}" "error")
  if [ "${is_valid}" = "false" ]; then
    exit 1
  else
    log_error "Something went wrong"
    exit 1
  fi
fi
