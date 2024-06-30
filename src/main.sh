#!/usr/bin/env bash

# Import all scripts
_import_all() {
  current_file=$(basename "$0")
  sh_files=$(find "$(dirname "$(realpath "$0")")" -type f -name "*.sh")
  for file in $sh_files; do
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
  parse_all_args args_map "$(echo "$@" | sed 's/^ *//')"
  parse_hook_args "${args_map["hook-args"]}"

  verify_global_vars

  case "${cmd_actual}" in
    "${cmd_grype_dir}")
      grype_dir "${args_map["grype-args"]}"
      ;;
    *)
      is_valid=$(validate_enum "hook" "${cmd_actual}" "${cmd_grype_dir}" "error")
      if [ "${is_valid}" = "false" ]; then
        exit 1
      else
        log_error "Something went wrong"
        exit 1
      fi
      ;;
  esac
}

main "$@"
