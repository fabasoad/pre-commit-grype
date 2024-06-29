#!/usr/bin/env sh

#MAIN_SCRIPT_PATH=$(realpath "$0")
#SRC_DIR_PATH=$(dirname "${MAIN_SCRIPT_PATH}")
#HOOKS_DIR_PATH="${SRC_DIR_PATH}/hooks"
#LIB_DIR_PATH="${SRC_DIR_PATH}/lib"
#ARGS_DIR_PATH="${LIB_DIR_PATH}/args"
#GLOBAL_VARS_DIR_PATH="${LIB_DIR_PATH}/global-vars"
#UTILS_DIR_PATH="${LIB_DIR_PATH}/utils"

# Import all scripts
import_all() {
  current_file=$(basename "$0")
  sh_files=$(find "$(dirname "$(realpath "$0")")" -type f -name "*.sh")
  for file in $sh_files; do
    if [ "$(basename "${file}")" != "${current_file}" ]; then
      . "${file}"
    fi
  done
}

main() {
  import_all
  verify_global_vars

  cmd_grype_dir="grype-dir"
  cmd_actual="$1"

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
}

main "$@"
