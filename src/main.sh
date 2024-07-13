#!/usr/bin/env bash

PRE_COMMIT_GRYPE_SRC_DIR=$(dirname $(realpath "$0"))

# Import all scripts
_import_all() {
  current_file=$(realpath "$0")
  exec_files=$(find "${PRE_COMMIT_GRYPE_SRC_DIR}" -type f -perm +111)
  for file in $exec_files; do
    if [ "${file}" != "${current_file}" ]; then
      . "${file}"
    fi
  done
}

main() {
  _import_all

  cmd_grype_dir="grype-dir"

  cmd_actual="$1"
  shift

  declare -A all_args_map
  parse_all_args all_args_map "$(echo "$@" | sed 's/^ *//' | sed 's/ *$//')"
  declare -A hook_args_map
  parse_hook_args hook_args_map "${all_args_map["hook-args"]}"

  # Apply configs
  set +u
  apply_logging_config "${hook_args_map["${CONFIG_LOG_LEVEL_ARG_NAME}"]}"

  if [ "${#hook_args_map[@]}" -ne 0 ]; then
    fabasoad_log "info" "Pre-commit hook arguments: $(map_to_str hook_args_map)"
  fi
  set -u

  case "${cmd_actual}" in
    "${cmd_grype_dir}")
      grype_dir "${all_args_map["grype-args"]}"
      ;;
    *)
      validate_enum "hook" "${cmd_actual}" "${cmd_grype_dir}"
      ;;
  esac
}

main "$@"
