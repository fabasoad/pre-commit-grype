#!/usr/bin/env sh

MAIN_SCRIPT_PATH=$(realpath "$0")
SRC_DIR_PATH=$(dirname "${MAIN_SCRIPT_PATH}")
HOOKS_DIR_PATH="${SRC_DIR_PATH}/hooks"
LIB_DIR_PATH="${SRC_DIR_PATH}/lib"
UTILS_DIR_PATH="${LIB_DIR_PATH}/utils"

. "${LIB_DIR_PATH}/default.sh"
. "${UTILS_DIR_PATH}/validators.sh"

args="$@"

case "${args:0:9}" in
  "grype-dir")
    . "${HOOKS_DIR_PATH}/grype-dir.sh"
    grype_dir "${args:10}"
    ;;
  *)
    is_valid=$(validate_enum "hook" "${hook}" "grype-dir" "error")
    if [ "${is_valid}" = "false" ]; then
      exit 1
    fi
    ;;
esac
