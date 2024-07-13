#!/usr/bin/env bash

# Import all scripts
_import_all() {
  current_file=$(basename "$0")
  exec_files=$(find "src" -type f -perm +111)
  for file in $exec_files; do
    if [ "$(basename "${file}")" != "${current_file}" ]; then
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

  fabasoad_log "info" "Pre-commit hook arguments: $(map_to_str hook_args_map)"
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
