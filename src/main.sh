#!/usr/bin/env bash

# Global variables
_global_config() {
  export FABASOAD_LOG_CONFIG_TEXT_COLOR="true"
  export FABASOAD_LOG_CONFIG_DATE_FORMAT="%s"
  export FABASOAD_LOG_CONFIG_OUTPUT_FORMAT="text"
  export FABASOAD_LOG_CONFIG_HEADER="pre-commit-grype"
  export FABASOAD_LOG_CONFIG_LOG_LEVEL="$(get_global_log_level)"
}

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

  declare -A args_map
  parse_all_args args_map "$(echo "$@" | sed 's/^ *//' | sed 's/ *$//')"
  declare -A logs_map
  parse_hook_args logs_map "${args_map["hook-args"]}"

  # Need to verify parameters that were parsed from hook args
  verify_global_vars
  # Setting global config, such as logging
  _global_config
  # Print logs from map if any
  for log_level in "${!logs_map[@]}"; do
    fabasoad_log "${log_level}" "${logs_map[$log_level]}"
  done

  case "${cmd_actual}" in
    "${cmd_grype_dir}")
      grype_dir "${args_map["grype-args"]}"
      ;;
    *)
      declare -A validation_logs_map
      is_valid=$(validate_enum validation_logs_map "hook" "${cmd_actual}" "${cmd_grype_dir}" "error")
      # Print logs from map if any
      for log_level in "${!validation_logs_map[@]}"; do
        fabasoad_log "${log_level}" "${validation_logs_map[$log_level]}"
      done

      if [ "${is_valid}" = "false" ]; then
        exit 1
      else
        fabasoad_log "error" "Something went wrong"
        exit 1
      fi
      ;;
  esac
}

main "$@"
